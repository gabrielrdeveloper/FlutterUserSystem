import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  List<User> _users = [];
  List<User> get users => _users;

  List<User> _originalUsers = [];

  UserListViewModel(this._userRepository);

  /// Carrega os usuários do repositório
  Future<void> loadUsers() async {
    try {
      _users = await _userRepository.getUsers();
      _originalUsers = List.from(_users);
      notifyListeners();
      print("[UserListViewModel] Usuários carregados: ${_users.length}");
    } catch (e) {
      print("[UserListViewModel] Erro ao carregar usuários: $e");
      _users = [];
      _originalUsers = [];
    }
  }

  /// Busca usuários com base em uma consulta
  void searchUsers(String query) {
    _users = query.isEmpty
        ? List.from(_originalUsers)
        : _originalUsers
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
    print("[UserListViewModel] Busca realizada: $query");
  }

  /// Adiciona um novo usuário
  Future<bool> addUser(User user) async {
    if (_users.any((u) => u.email == user.email)) {
      print("[UserListViewModel] Email já cadastrado: ${user.email}");
      return false;
    }

    try {
      await _userRepository.addUser(user);
      _users.add(user);
      _originalUsers.add(user);
      notifyListeners();
      print("[UserListViewModel] Usuário adicionado: ${user.name}");
      return true;
    } catch (e) {
      print("[UserListViewModel] Erro ao adicionar usuário: $e");
      return false;
    }
  }

  /// Atualiza um usuário existente
  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user);

      final index = _users.indexWhere((u) => u.uid == user.uid);
      if (index != -1) {
        _users[index] = user;
        _originalUsers[index] = user;
        notifyListeners();
        print("[UserListViewModel] Usuário atualizado: ${user.name}");
      }
      return true;
    } catch (e) {
      print("[UserListViewModel] Erro ao atualizar usuário: $e");
      return false;
    }
  }

  /// Remove um usuário pelo UID
  Future<bool> deleteUser(String uid) async {
    try {
      await _userRepository.deleteUser(uid);
      _users.removeWhere((user) => user.uid == uid);
      _originalUsers.removeWhere((user) => user.uid == uid);
      notifyListeners();
      print("[UserListViewModel] Usuário removido: $uid");
      return true;
    } catch (e) {
      print("[UserListViewModel] Erro ao remover usuário: $e");
      return false;
    }
  }

  /// Ordena os usuários pelo nome
  void sortUsersByName() {
    _users.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
    print("[UserListViewModel] Usuários ordenados por nome.");
  }

  /// Valida login com e-mail e senha
  Future<bool> validateLogin(String email, String password) async {
    try {
      final users = await _userRepository.getUsers();
      final isValid = users.any((user) => user.email == email && user.password == password);
      print("[UserListViewModel] Login ${isValid ? 'válido' : 'inválido'} para o email: $email");
      return isValid;
    } catch (e) {
      print("[UserListViewModel] Erro ao validar login: $e");
      return false;
    }
  }
}