import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;

  LoginViewModel(this._userRepository);

  /// Faz o login do usuário
  Future<bool> login(String email, String password) async {
    try {
      final users = await _userRepository.getUsers();
      final user = users.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () => throw Exception('Invalid email or password'),
      );

      _loggedInUser = user;
      notifyListeners();
      return true;
    } catch (e) {
      print("Login failed: $e");
      return false;
    }
  }

  /// Faz o login anônimo
  void loginAnonymously() {
    _loggedInUser = null;
    notifyListeners();
  }

  /// Faz logout do usuário
  void logout() {
    _loggedInUser = null;
    notifyListeners();
  }
}