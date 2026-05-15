import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  Future<void> createUser(UserModel user) async {
    await _collection.doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUserByUid(String uid) async {
    try {
      final doc = await _collection.doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _collection.doc(uid).update(data);
  }
}
