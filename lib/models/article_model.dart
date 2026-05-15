import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String type; // venta, intercambio
  final String location;
  final String status; // disponible, reservado, vendido
  final String sellerUid;
  final String sellerEmail;
  final DateTime createdAt;
  final String? imageUrl;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.type,
    required this.location,
    required this.status,
    required this.sellerUid,
    required this.sellerEmail,
    required this.createdAt,
    String? imageUrl,
  }) : imageUrl = imageUrl;

  factory Article.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Article(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      type: data['type'] ?? 'venta',
      location: data['location'] ?? 'Bogotá - Sede Principal',
      status: data['status'] ?? 'disponible',
      sellerUid: data['sellerUid'] ?? '',
      sellerEmail: data['sellerEmail'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'type': type,
      'location': location,
      'status': status,
      'sellerUid': sellerUid,
      'sellerEmail': sellerEmail,
      'createdAt': Timestamp.fromDate(createdAt),
      'imageUrl': imageUrl,
    };
  }
}
