import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<String?> register(String email, String password, String phone) async {
    if (!email.endsWith('@uan.edu.co')) {
      return 'Solo se permiten correos @uan.edu.co';
    }
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = _auth.currentUser!;
      final userModel = UserModel(
        uid: user.uid,
        email: email,
        phone: phone,
        createdAt: DateTime.now(),
      );
      await UserRepository().createUser(userModel);
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
