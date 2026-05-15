import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/article_model.dart';
import '../repositories/article_repository.dart';

class ArticleProvider extends ChangeNotifier {
  final ArticleRepository _repo = ArticleRepository();
  List<Article> _articles = [];
  bool _loading = false;
  String? _error;
  String _searchQuery = '';

  List<Article> get articles => _articles;
  bool get loading => _loading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  List<Article> get filteredArticles {
    if (_searchQuery.isEmpty) return _articles;
    final query = _searchQuery.toLowerCase();
    return _articles.where((a) =>
      a.title.toLowerCase().contains(query) ||
      a.description.toLowerCase().contains(query)
    ).toList();
  }

  ArticleProvider() {
    _repo.getArticles().listen((articles) {
      _articles = articles;
      notifyListeners();
    });
  }

  Future<void> addArticle({
    required String title,
    required String description,
    required double price,
    required String category,
    required String type,
    required String location,
    String? imageUrl,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final user = FirebaseAuth.instance.currentUser!;
      final article = Article(
        id: '',
        title: title,
        description: description,
        price: price,
        category: category,
        type: type,
        location: location,
        status: 'disponible',
        sellerUid: user.uid,
        sellerEmail: user.email ?? '',
        createdAt: DateTime.now(),
        imageUrl: imageUrl,
      );
      await _repo.createArticle(article);
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> updateArticle(String id, {
    required String title,
    required String description,
    required double price,
    required String type,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      if (price <= 0) throw Exception('El precio debe ser mayor a 0');
      await _repo.updateArticle(id, {
        'title': title,
        'description': description,
        'price': price,
        'type': type,
      });
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> deleteArticle(String id) async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      await _repo.deleteArticle(id);
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> changeStatus(String id, String currentStatus) async {
    final newStatus = currentStatus == 'disponible' ? 'vendido' : 'disponible';
    try {
      await _repo.updateArticle(id, {'status': newStatus});
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
