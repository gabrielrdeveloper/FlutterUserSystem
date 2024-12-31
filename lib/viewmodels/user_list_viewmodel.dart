import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  // Lista local de usuários carregados
  List<User> _users = [];
  List<User> get users => _users;

  UserListViewModel(this._userRepository);

  List<User> _originalUsers = []; // Lista original para buscas

  /// Carrega os usuários da fonte de dados e notifica a UI
  Future<void> loadUsers() async {
    try {
      _users = await _userRepository.getUsers();
      _originalUsers = List.from(_users); // Salva uma cópia da lista original
      notifyListeners(); // Atualiza a interface
    } catch (e) {
      print("Failed to load users: $e");
      _users = [];
      _originalUsers = [];
    }
  }

  /// Adiciona um novo usuário (verificando duplicidade por e-mail)
  Future<bool> addUser(User user) async {
    try {
      // Verifica se o e-mail já existe
      if (_users.any((u) => u.email == user.email)) {
        return false; // Usuário já existe
      }

      // Adiciona o usuário ao repositório e atualiza a lista local
      await _userRepository.addUser(user);
      _users.add(user);
      notifyListeners(); // Notifica a UI sobre a mudança
      return true; // Adicionado com sucesso
    } catch (e) {
      print("Error adding user: $e");
      return false; // Falha na adição
    }
  }

  /// Atualiza um usuário existente
  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user);

      // Atualiza o usuário na lista local
      final index = _users.indexWhere((u) => u.uid == user.uid);
      if (index != -1) {
        _users[index] = user;
        notifyListeners(); // Notifica a UI
      }
      return true;
    } catch (e) {
      print("Failed to update user: $e");
      return false;
    }
  }

  /// Remove um usuário pelo UID
  Future<bool> deleteUser(String uid) async {
    try {
      await _userRepository.deleteUser(uid);

      // Verifica o tamanho da lista antes e depois de tentar remover
      final initialLength = _users.length;
      _users.removeWhere((user) => user.uid == uid);
      final isRemoved = _users.length < initialLength; // Verifica se algo foi removido

      notifyListeners(); // Notifica a UI
      return isRemoved; // Retorna true se algum usuário foi removido
    } catch (e) {
      print("Failed to delete user: $e");
      return false; // Retorna false em caso de falha
    }
  }

  /// Busca um usuário pelo UID
  User? findUserById(String uid) {
    try {
      return _users.firstWhere((user) => user.uid == uid);
    } catch (e) {
      print("User not found: $e");
      return null;
    }
  }

  /// Ordena a lista de usuários pelo nome
  void sortUsersByName() {
    _users.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners(); // Notifica a UI
  }

  /// Filtra usuários com base em uma consulta sem perder a lista original
  void searchUsers(String query) {
    if (query.isEmpty) {
      _users = List.from(_originalUsers); // Restaura a lista original
    } else {
      _users = _originalUsers.where((user) =>
          user.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners(); // Notifica a UI
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

  void printRegisteredUsers() async {
    final users = await _userRepository.getUsers();
    for (var user in users) {
      print('User: ${user.name}, Email: ${user.email}, Password: ${user.password}');
    }
  }
}