import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/auth_provider.dart';
import 'providers/article_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final splashSeen = prefs.getBool('swap_splash_seen') ?? false;
  runApp(SwapApp(showSplash: !splashSeen));
}

class SwapApp extends StatelessWidget {
  final bool showSplash;
  const SwapApp({super.key, required this.showSplash});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
      ],
      child: MaterialApp(
        title: 'SWAP',
        theme: AppTheme.lightTheme,
        home: showSplash ? const SplashScreen() : const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    if (auth.user != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
