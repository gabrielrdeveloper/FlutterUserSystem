import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'family_viewmodel.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final FamilyViewModel _familyViewModel; // Dependência de FamilyViewModel
  User? _loggedInUser;

  User? get loggedInUser => _loggedInUser;

  LoginViewModel(this._userRepository, this._familyViewModel);

  /// Faz o login do usuário
  Future<bool> login(String email, String password) async {
    try {
      print("[LoginViewModel] Iniciando login para o email: $email");

      // Busca os usuários no repositório
      final users = await _userRepository.getUsers();
      print("[LoginViewModel] Usuários encontrados: ${users.length}");

      // Verifica se o email e senha correspondem a algum usuário
      final user = users.firstWhere(
            (user) => user.email == email && user.password == password,
        orElse: () {
          print("[LoginViewModel] Nenhum usuário encontrado com essas credenciais.");
          throw Exception('Invalid email or password');
        },
      );

      // Configura o usuário logado e atualiza a FamilyViewModel
      _loggedInUser = user;
      print("[LoginViewModel] Login bem-sucedido para o usuário: ${user.name}");

      _familyViewModel.setLoggedInUser(user);
      notifyListeners();

      return true; // Login bem-sucedido
    } catch (e) {
      print("[LoginViewModel] Erro no login: $e");
      return false; // Falha no login
    }
  }

  /// Faz o login anônimo
  void loginAnonymously() {
    print("[LoginViewModel] Login anônimo realizado.");
    _loggedInUser = null;
    _familyViewModel.clearFamilyMembers(); // Limpa familiares
    notifyListeners();
  }

  /// Faz logout do usuário
  void logout() {
    print("[LoginViewModel] Logout realizado.");
    _loggedInUser = null;
    _familyViewModel.clearFamilyMembers(); // Limpa familiares
    notifyListeners();
  }

  /// Verifica se há um usuário logado
  bool get isLoggedIn {
    final status = _loggedInUser != null;
    print("[LoginViewModel] Usuário logado? $status");
    return status;
  }
}