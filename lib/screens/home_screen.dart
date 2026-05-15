import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/article_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/article_card.dart';
import 'article_detail_screen.dart';
import 'add_article_screen.dart';
import 'search_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final articleProvider = context.watch<ArticleProvider>();
    final articles = articleProvider.filteredArticles;
    final loading = articleProvider.loading;

    return Scaffold(
      backgroundColor: AppColors.mentaClaro,
      appBar: AppBar(
        backgroundColor: AppColors.verdeTeal,
        elevation: 0,
        title: Text(
          'SWAP',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.white, size: 28),
            onPressed: () {
              if (auth.user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.verdeTeal,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: AppColors.verdeTeal, size: 22),
                    const SizedBox(width: 10),
                    Text(
                      '¿Qué buscas hoy?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.verdeTeal,
                    ),
                  )
                : articles.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.inbox,
                                size: 48, color: Colors.grey),
                            const SizedBox(height: 12),
                            Text(
                              'No hay artículos publicados aún',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return ArticleCard(
                            article: article,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ArticleDetailScreen(article: article),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: auth.user != null
          ? FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddArticleScreen()),
              ),
              backgroundColor: AppColors.verdeTeal,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
