import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  static const String _usersKey = 'users';

  List<User> _users = [];

  LocalUserRepository({List<User>? initialUsers}) {
    if (initialUsers != null && initialUsers.isNotEmpty) {
      _users = List.from(initialUsers); // Inicializa a lista local
      _saveUsers(_users); // Salva no armazenamento persistente
    }
  }

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<void> _saveUsers(List<User> users) async {
    final prefs = await _prefs;
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, usersJson);
  }

  Future<List<User>> _fetchUsers() async {
    final prefs = await _prefs;
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    return usersJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
  }

  @override
  Future<void> addUser(User user) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    _users.add(user); // Adiciona o novo usuário
    await _saveUsers(_users); // Salva a lista atualizada
  }

  @override
  Future<User> getUser(String uid) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    return _users.firstWhere(
          (user) => user.uid == uid,
      orElse: () => throw Exception('User not found'),
    );
  }

  @override
  Future<void> updateUser(User user) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('User not found');
    }
    _users[index] = user; // Atualiza o usuário
    await _saveUsers(_users); // Salva a lista atualizada
  }

  @override
  Future<int> deleteUser(String uid) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    _users.removeWhere((user) => user.uid == uid);
    await _saveUsers(_users); // Salva a lista atualizada
    return _users.length; // Retorna o número de usuários restantes
  }

  @override
  Future<List<User>> getUsers() async {
    _users = await _fetchUsers(); // Sempre retorna os usuários sincronizados
    return _users;
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    return _users.where((user) => user.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<int> countUsers() async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    return _users.length;
  }
}