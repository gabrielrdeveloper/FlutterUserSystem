import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  static const String _usersKey = 'users';

  List<User> _users = []; // Lista local de usuários

  LocalUserRepository({List<User>? initialUsers}) {
    if (initialUsers != null && initialUsers.isNotEmpty) {
      _users = List.from(initialUsers); // Inicializa a lista local
      _saveUsers(_users); // Salva no armazenamento persistente
      print("[LocalUserRepository] Usuários iniciais salvos: ${_users.length}");
    }
  }

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  /// Salva a lista de usuários no armazenamento persistente
  Future<void> _saveUsers(List<User> users) async {
    final prefs = await _prefs;
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    await prefs.setStringList(_usersKey, usersJson);
    print("[LocalUserRepository] Usuários salvos: ${users.length}");
  }

  /// Carrega os usuários do armazenamento persistente
  Future<List<User>> _fetchUsers() async {
    final prefs = await _prefs;
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    final users = usersJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
    print("[LocalUserRepository] Usuários carregados: ${users.length}");
    return users;
  }

  /// Adiciona um novo usuário ao sistema
  @override
  Future<void> addUser(User user) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    _users.add(user); // Adiciona o novo usuário
    await _saveUsers(_users); // Salva a lista atualizada
    print("[LocalUserRepository] Usuário adicionado: ${user.name}");
  }

  /// Retorna um usuário pelo UID
  @override
  Future<User> getUser(String uid) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    final user = _users.firstWhere(
          (user) => user.uid == uid,
      orElse: () => throw Exception('[LocalUserRepository] Usuário não encontrado: $uid'),
    );
    print("[LocalUserRepository] Usuário encontrado: ${user.name}");
    return user;
  }

  /// Atualiza os dados de um usuário existente
  @override
  Future<void> updateUser(User user) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('[LocalUserRepository] Usuário não encontrado para atualização: ${user.uid}');
    }
    _users[index] = user; // Atualiza o usuário
    await _saveUsers(_users); // Salva a lista atualizada
    print("[LocalUserRepository] Usuário atualizado: ${user.name}");
  }

  /// Remove um usuário pelo UID
  @override
  Future<int> deleteUser(String uid) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    _users.removeWhere((user) => user.uid == uid);
    await _saveUsers(_users); // Salva a lista atualizada
    print("[LocalUserRepository] Usuário removido: $uid");
    return _users.length; // Retorna o número de usuários restantes
  }

  /// Retorna todos os usuários
  @override
  Future<List<User>> getUsers() async {
    _users = await _fetchUsers(); // Sempre retorna os usuários sincronizados
    print("[LocalUserRepository] Retornando todos os usuários: ${_users.length}");
    return _users;
  }

  /// Busca usuários pelo nome
  @override
  Future<List<User>> searchUsers(String query) async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    final results = _users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print("[LocalUserRepository] Usuários encontrados na busca: ${results.length}");
    return results;
  }

  /// Conta o número total de usuários
  @override
  Future<int> countUsers() async {
    _users = await _fetchUsers(); // Garante que a lista esteja sincronizada
    print("[LocalUserRepository] Total de usuários no sistema: ${_users.length}");
    return _users.length;
  }
}