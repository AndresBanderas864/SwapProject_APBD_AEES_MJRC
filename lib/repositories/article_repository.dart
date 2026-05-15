import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/article_model.dart';

class ArticleRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('articles');

  Future<void> createArticle(Article article) async {
    await _collection.add(article.toMap());
  }

  Stream<List<Article>> getArticles() {
    return _collection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList());
  }

  Future<Article?> getArticleById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    return Article.fromFirestore(doc);
  }

  Future<void> updateArticle(String id, Map<String, dynamic> data) async {
    await _collection.doc(id).update(data);
  }

  Future<void> deleteArticle(String id) async {
    await _collection.doc(id).delete();
  }

  Future<List<Article>> getRelatedArticles(String category, String excludeId) async {
    final snapshot = await _collection
        .where('category', isEqualTo: category)
        .limit(6)
        .get();
    return snapshot.docs
        .map((doc) => Article.fromFirestore(doc))
        .where((a) => a.id != excludeId)
        .take(5)
        .toList();
  }

  Stream<List<Article>> getArticlesByUser(String uid) {
    return _collection
        .where('sellerUid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList());
  }
}
