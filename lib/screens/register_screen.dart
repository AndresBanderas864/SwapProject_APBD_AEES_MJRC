import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _localError;

  bool _validatePhone(String phone) {
    return phone.length == 10 && phone.startsWith('3');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Registro — SWAP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo @uan.edu.co'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirmar contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono (10 dígitos, ej: 3001234567)',
                ),
                keyboardType: TextInputType.phone,
                maxLength: 10,
              ),
              const SizedBox(height: 8),
              if (_localError != null)
                Text(_localError!, style: const TextStyle(color: Colors.red)),
              if (auth.error != null)
                Text(auth.error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              auth.loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() => _localError = null);
                        if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          setState(() =>
                              _localError = 'Las contraseñas no coinciden');
                          return;
                        }
                        if (!_validatePhone(_phoneController.text.trim())) {
                          setState(() => _localError =
                              'El teléfono debe tener 10 dígitos y comenzar con 3');
                          return;
                        }
                        await auth.register(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                          _phoneController.text.trim(),
                        );
                        if (auth.error == null && context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text('Crear cuenta'),
                    ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('¿Ya tienes cuenta? Inicia sesión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
