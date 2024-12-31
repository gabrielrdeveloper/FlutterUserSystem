import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  List<User> _users = [];
  List<User> get users => _users;

  List<User> _originalUsers = []; // Lista para manter a cópia original para buscas

  UserListViewModel(this._userRepository);

  /// Carrega os usuários do repositório
  Future<void> loadUsers() async {
    try {
      _users = await _userRepository.getUsers();
      _originalUsers = List.from(_users); // Mantém uma cópia para buscas
      notifyListeners(); // Atualiza a interface
    } catch (e) {
      print('Error loading users: $e');
      _users = [];
      _originalUsers = [];
    }
  }

  /// Busca usuários com base em uma consulta
  void searchUsers(String query) {
    if (query.isEmpty) {
      _users = List.from(_originalUsers); // Restaura a lista original
    } else {
      _users = _originalUsers.where((user) =>
          user.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners(); // Atualiza a interface
  }

  /// Adiciona um novo usuário
  Future<bool> addUser(User user) async {
    try {
      // Verifica se já existe um usuário com o mesmo email
      if (_users.any((u) => u.email == user.email)) {
        return false; // Usuário já existe
      }

      await _userRepository.addUser(user); // Adiciona ao repositório
      _users.add(user); // Atualiza a lista local
      _originalUsers.add(user); // Atualiza a lista original
      notifyListeners(); // Atualiza a interface
      return true;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  /// Atualiza um usuário existente
  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user); // Atualiza no repositório

      // Atualiza o usuário na lista local
      final index = _users.indexWhere((u) => u.uid == user.uid);
      if (index != -1) {
        _users[index] = user;
        _originalUsers[index] = user; // Também atualiza na lista original
        notifyListeners();
      }
      return true;
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  /// Remove um usuário pelo UID
  Future<bool> deleteUser(String uid) async {
    try {
      await _userRepository.deleteUser(uid); // Remove do repositório

      // Remove da lista local
      _users.removeWhere((user) => user.uid == uid);
      _originalUsers.removeWhere((user) => user.uid == uid);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error deleting user: $e');
      return false;
    }
  }

  /// Busca um usuário pelo UID
  User? findUserById(String uid) {
    try {
      return _users.firstWhere((user) => user.uid == uid);
    } catch (e) {
      print('User not found: $e');
      return null;
    }
  }

  /// Ordena os usuários pelo nome
  void sortUsersByName() {
    _users.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners(); // Atualiza a interface
  }

  Future<bool> validateLogin(String email, String password) async {
    try {
      // Busca todos os usuários do repositório
      final users = await _userRepository.getUsers();

      // Verifica se há algum usuário com o e-mail e senha fornecidos
      return users.any((user) => user.email == email && user.password == password);
    } catch (e) {
      print('Login validation failed: $e');
      return false;
    }
  }
}