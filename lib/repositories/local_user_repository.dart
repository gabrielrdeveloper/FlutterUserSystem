import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  static const String _usersKey = 'users';
  List<User> _users = [];

  LocalUserRepository({List<User>? initialUsers}) {
    if (initialUsers != null && initialUsers.isNotEmpty) {
      _users = List.from(initialUsers);
      _saveUsers(_users);
      print("[LocalUserRepository] Usuários iniciais salvos: ${_users.length}");
    }
  }

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<void> _saveUsers(List<User> users) async {
    final prefs = await _prefs;
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, usersJson);
    print("[LocalUserRepository] Usuários salvos: ${users.length}");
  }

  Future<List<User>> _fetchUsers() async {
    final prefs = await _prefs;
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    final users = usersJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
    print("[LocalUserRepository] Usuários carregados: ${users.length}");
    return users;
  }

  @override
  Future<void> addUser(User user) async {
    _users = await _fetchUsers();
    _users.add(user);
    await _saveUsers(_users);
    print("[LocalUserRepository] Usuário adicionado: ${user.name}");
  }

  @override
  Future<User> getUser(String uid) async {
    _users = await _fetchUsers();
    final user = _users.firstWhere(
          (user) => user.uid == uid,
      orElse: () => throw Exception('[LocalUserRepository] Usuário não encontrado: $uid'),
    );
    print("[LocalUserRepository] Usuário encontrado: ${user.name}");
    return user;
  }

  @override
  Future<void> updateUser(User user) async {
    _users = await _fetchUsers();
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('[LocalUserRepository] Usuário não encontrado para atualização: ${user.uid}');
    }
    _users[index] = user;
    await _saveUsers(_users);
    print("[LocalUserRepository] Usuário atualizado: ${user.name}");
  }

  @override
  Future<int> deleteUser(String uid) async {
    _users = await _fetchUsers();
    _users.removeWhere((user) => user.uid == uid);
    await _saveUsers(_users);
    print("[LocalUserRepository] Usuário removido: $uid");
    return _users.length;
  }

  @override
  Future<List<User>> getUsers() async {
    _users = await _fetchUsers();
    print("[LocalUserRepository] Retornando todos os usuários: ${_users.length}");
    return _users;
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    _users = await _fetchUsers();
    final results = _users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print("[LocalUserRepository] Usuários encontrados na busca: ${results.length}");
    return results;
  }

  @override
  Future<int> countUsers() async {
    _users = await _fetchUsers();
    print("[LocalUserRepository] Total de usuários no sistema: ${_users.length}");
    return _users.length;
  }
}