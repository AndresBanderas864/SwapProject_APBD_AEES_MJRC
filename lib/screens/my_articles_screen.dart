import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../repositories/article_repository.dart';
import '../models/article_model.dart';
import '../providers/article_provider.dart';
import '../screens/edit_article_screen.dart';

class MyArticlesScreen extends StatelessWidget {
  const MyArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final repo = ArticleRepository();

    return Scaffold(
      appBar: AppBar(title: const Text('Mis publicaciones')),
      body: StreamBuilder<List<Article>>(
        stream: repo.getArticlesByUser(uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final articles = snapshot.data ?? [];
          if (articles.isEmpty) {
            return const Center(child: Text('No tienes publicaciones aún.'));
          }
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(article.title),
                  subtitle: Text(
                    '${article.type} — \$${article.price.toStringAsFixed(0)} — ${article.status}',
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) async {
                      final provider = context.read<ArticleProvider>();
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditArticleScreen(article: article),
                          ),
                        );
                      } else if (value == 'status') {
                        await provider.changeStatus(article.id, article.status);
                      } else if (value == 'delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Eliminar artículo'),
                            content: const Text(
                                '¿Estás seguro de que quieres eliminar esta publicación?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Eliminar',
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true && context.mounted) {
                          await context.read<ArticleProvider>().deleteArticle(article.id);
                        }
                      }
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(value: 'edit', child: Text('Editar')),
                      const PopupMenuItem(
                          value: 'status', child: Text('Cambiar estado')),
                      const PopupMenuItem(
                          value: 'delete',
                          child: Text('Eliminar',
                              style: TextStyle(color: Colors.red))),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
