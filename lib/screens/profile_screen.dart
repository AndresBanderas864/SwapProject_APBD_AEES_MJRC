import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/article_model.dart';
import '../models/user_model.dart';
import '../repositories/article_repository.dart';
import '../repositories/user_repository.dart';
import '../theme/app_theme.dart';
import 'add_article_screen.dart';
import 'edit_article_screen.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? _userModel;
  bool _loadingUser = true;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      });
      return;
    }
    _fetchUserProfile(user.uid);
  }

  Future<void> _fetchUserProfile(String uid) async {
    final userModel = await UserRepository().getUserByUid(uid);
    if (mounted) {
      setState(() {
        _userModel = userModel;
        _loadingUser = false;
      });
    }
  }

  Widget _articleRow(Article article) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: article.imageUrl != null
                  ? Image.network(
                      article.imageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.carbonOscuro,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${article.price.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppColors.verdeTeal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.mentaClaro,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      article.status,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.verdeTeal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditArticleScreen(article: article),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: AppColors.verdeTeal,
                    ),
                    child: Text(
                      'Editar publicación',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.verdeTeal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 80,
      height: 80,
      color: AppColors.mentaClaro,
      child: const Center(
        child: Icon(Icons.image, color: Colors.grey, size: 32),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const SizedBox.shrink();

    return Scaffold(
      backgroundColor: AppColors.mentaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.verdeTeal,
        elevation: 0,
        title: Text(
          'Usuario',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile header
                  Container(
                    width: double.infinity,
                    color: AppColors.mentaClaro,
                    padding: const EdgeInsets.symmetric(
                        vertical: 32, horizontal: 24),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.coralSuave,
                          backgroundImage: _userModel?.photoUrl != null
                              ? NetworkImage(_userModel!.photoUrl!)
                              : null,
                          child: _userModel?.photoUrl == null
                              ? const Icon(Icons.person, size: 48, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.email ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.carbonOscuro,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6),
                        _loadingUser
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.verdeTeal,
                                ),
                              )
                            : Text(
                                _userModel?.phone ?? '',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                      ],
                    ),
                  ),
                  // Mis publicaciones header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Mis publicaciones',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.carbonOscuro,
                      ),
                    ),
                  ),
                  // Articles list
                  StreamBuilder<List<Article>>(
                    stream: ArticleRepository()
                        .getArticlesByUser(user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(
                                color: AppColors.verdeTeal),
                          ),
                        );
                      }
                      final articles = snapshot.data ?? [];
                      if (articles.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(Icons.inbox,
                                    size: 48, color: Colors.grey),
                                const SizedBox(height: 12),
                                Text(
                                  'Aún no tienes publicaciones',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: articles
                            .map((a) => _articleRow(a))
                            .toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // Sticky bottom button
          Container(
            color: AppColors.mentaClaro,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const AddArticleScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.verdeTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Publica algo nuevo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
