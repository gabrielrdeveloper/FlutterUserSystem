import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  // Lista local de usuários carregados
  List<User> _users = [];
  List<User> get users => _users;

  UserListViewModel(this._userRepository);

  // Lista original para restaurar após buscas
  List<User> _originalUsers = [];

  /// Carrega todos os usuários do repositório e atualiza a interface
  Future<void> loadUsers() async {
    try {
      _users = await _userRepository.getUsers();
      _originalUsers = List.from(_users); // Mantém a lista original para buscas
      notifyListeners();
    } catch (e) {
      print("Failed to load users: $e");
      _users = [];
      _originalUsers = [];
    }
  }

  /// Filtra usuários com base em uma consulta
  void searchUsers(String query) {
    if (query.isEmpty) {
      _users = List.from(_originalUsers); // Restaura a lista original
    } else {
      _users = _originalUsers.where((user) =>
          user.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners(); // Atualiza a interface
  }

  /// Apenas para depuração: imprime todos os usuários registrados
  Future<void> printRegisteredUsers() async {
    try {
      final users = await _userRepository.getUsers();
      for (var user in users) {
        print('User: ${user.name}, Email: ${user.email}, Password: ${user.password}');
      }
    } catch (e) {
      print("Failed to fetch users: $e");
    }
  }
}