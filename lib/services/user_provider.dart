import 'package:flutter/material.dart';
import 'package:moviemate/models/user_model.dart';
import 'auth_service.dart';

class UserProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  UserProvider() {
    _authService.user.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password) async {
    _user = await _authService.signInWithEmailAndPassword(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password, String userName) async {
    _user = await _authService.registerWithEmailAndPassword(email, password, userName);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
