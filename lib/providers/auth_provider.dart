import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  String? _error;
  bool _loading = false;

  User? get user => _user;
  String? get error => _error;
  bool get loading => _loading;

  AuthProvider() {
    _authService.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> register(String email, String password, String phone) async {
    _loading = true;
    _error = null;
    notifyListeners();
    _error = await _authService.register(email, password, phone);
    _loading = false;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    _loading = true;
    _error = null;
    notifyListeners();
    _error = await _authService.login(email, password);
    _loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}
