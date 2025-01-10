import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'family_list_viewmodel.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final FamilyViewModel _familyViewModel;

  User? _loggedInUser;
  String? _errorMessage;

  User? get loggedInUser => _loggedInUser;
  String? get errorMessage => _errorMessage;

  LoginViewModel(this._userRepository, this._familyViewModel);

  /// Realiza o login do usuário
  Future<void> login(String email, String password) async {
    _errorMessage = null;
    try {
      final users = await _userRepository.getUsers();
      final user = users.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () => throw Exception('Email ou senha inválidos.'),
      );

      _loggedInUser = user;
      _familyViewModel.setLoggedInUser(user);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Erro ao realizar login: $e";
      notifyListeners();
    }
  }

  /// Realiza login anônimo
  void loginAnonymously() {
    _loggedInUser = null;
    _familyViewModel.clearFamilyMembers();
    notifyListeners();
  }

  /// Realiza logout do usuário
  void logout() {
    _loggedInUser = null;
    // _familyViewModel.clearFamilyMembers();
    notifyListeners();
  }

  /// Verifica se há um usuário logado
  bool get isLoggedIn => _loggedInUser != null;

  /// Validação de email
  bool isEmailValid(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  /// Validação de senha
  bool isPasswordValid(String password) {
    return password.length >= 6;
  }
}