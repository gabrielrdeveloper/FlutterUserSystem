import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  List<User> _users = [];
  List<User> get users => _users;

  UserListViewModel(this._userRepository);

  Future<void> loadUsers() async {
    try {
      _users = await _userRepository.getUsers();
      notifyListeners();
    } catch (e) {
      print("Failed to load users: $e");
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      notifyListeners();
      return;
    }

    _users = _users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    notifyListeners();
  }

  Future<bool> addUser(User user) async {
    try {
      if (_users.any((u) => u.email == user.email)) {
        return false;
      }

      await _userRepository.addUser(user);
      _users.add(user);
      notifyListeners();
      return true;
    } catch (e) {
      print("Error adding user: $e");
      return false;
    }
  }

  Future<bool> validateLogin(String email, String password) async {
    try {
      // Busca todos os usuários do repositório
      final users = await _userRepository.getUsers();

      // Verifica se há algum usuário com o e-mail e senha fornecidos
      return users.any(
            (user) => user.email == email && user.password == password,
      );
    } catch (e) {
      print("Login validation failed: $e");
      return false;
    }
  }
}