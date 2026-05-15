import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/article_model.dart';
import '../repositories/article_repository.dart';
import '../repositories/user_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/article_card.dart';
import '../widgets/contact_bottom_sheet.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailScreen({super.key, required this.article});

  Future<void> _showContactSheet(BuildContext context) async {
    final seller = await UserRepository().getUserByUid(article.sellerUid);
    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (_) => ContactBottomSheet(
          sellerEmail: article.sellerEmail,
          sellerPhone: seller?.phone,
        ),
      );
    }
  }

  Widget _overlayButton({required Widget child, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _chip(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mentaClaro,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                // Image
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: article.imageUrl != null
                      ? Image.network(
                          article.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: AppColors.mentaClaro,
                            child: const Center(
                              child: Icon(Icons.image,
                                  size: 48, color: Colors.grey),
                            ),
                          ),
                          loadingBuilder: (_, child, progress) {
                            if (progress == null) return child;
                            return Container(
                              color: AppColors.mentaClaro,
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: AppColors.verdeTeal),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.mentaClaro,
                          child: const Center(
                            child:
                                Icon(Icons.image, size: 48, color: Colors.grey),
                          ),
                        ),
                ),
                // Overlay buttons
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  child: _overlayButton(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back,
                        size: 20, color: AppColors.carbonOscuro),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top + 12,
                  right: 16,
                  child: _overlayButton(
                    onTap: () {},
                    child: const Icon(Icons.bookmark_border,
                        size: 20, color: AppColors.carbonOscuro),
                  ),
                ),
                // White card overlapping image
                Container(
                  margin: const EdgeInsets.only(top: 260),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        Text(
                          '\$${article.price.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: AppColors.verdeTeal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Title
                        Text(
                          article.title,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.carbonOscuro,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Chips
                        Row(
                          children: [
                            _chip(article.type, AppColors.coralSuave,
                                AppColors.carbonOscuro),
                            const SizedBox(width: 8),
                            _chip(
                              article.status,
                              AppColors.mentaClaro,
                              AppColors.verdeTeal,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(color: AppColors.coralSuave),
                        const SizedBox(height: 12),
                        // Description
                        Text(
                          'Descripción',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.carbonOscuro,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          article.description,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: AppColors.carbonOscuro,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Location
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 18, color: AppColors.coralCalido),
                            const SizedBox(width: 6),
                            Text(
                              'Publicado en: ',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.carbonOscuro,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                article.location,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppColors.carbonOscuro,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Divider(color: AppColors.coralSuave),
                        const SizedBox(height: 20),
                        // Contactar button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () => _showContactSheet(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.verdeTeal,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'Contactar vendedor',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Related articles
                        FutureBuilder<List<Article>>(
                          future: ArticleRepository()
                              .getRelatedArticles(article.category, article.id),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const SizedBox.shrink();
                            }
                            final related = snapshot.data!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'También te podría gustar',
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.carbonOscuro,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 240,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: related.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 12),
                                    itemBuilder: (context, index) {
                                      final rel = related[index];
                                      return SizedBox(
                                        width: 160,
                                        child: ArticleCard(
                                          article: rel,
                                          onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  ArticleDetailScreen(
                                                      article: rel),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
