import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  static const String _usersKey = 'users';

  final List<User> _users = [];
  LocalUserRepository({List<User>? initialUsers}) {
    if (initialUsers != null && initialUsers.isNotEmpty) {
      _users.addAll(initialUsers);
      _saveUsers(_users);
    }
  }

  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  Future<void> _saveUsers(List<User> users) async {
    final prefs = await _prefs;
    final usersJson = users.map((user) => jsonEncode(user.toJson())).toList();
    print('Saving users: $usersJson');
    await prefs.setStringList(_usersKey, usersJson);
  }

  Future<List<User>> _fetchUsers() async {
    final prefs = await _prefs;
    final usersJson = prefs.getStringList(_usersKey) ?? [];
    print('Fetched users: $usersJson');
    return usersJson.map((userJson) => User.fromJson(jsonDecode(userJson))).toList();
  }

  @override
  Future<void> addUser(User user) async {
    _users.add(user);
    await _saveUsers(_users);
  }

  @override
  Future<User> getUser(String uid) async {
    final users = await _fetchUsers();
    return users.firstWhere(
          (user) => user.uid == uid,
      orElse: () => throw Exception('User not found'),
    );
  }

  @override
  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('User not found');
    }
    _users[index] = user;
    await _saveUsers(_users);
  }

  @override
  Future<int> deleteUser(String uid) async {
    _users.removeWhere((user) => user.uid == uid);
    await _saveUsers(_users);
    return _users.length;
  }

  @override
  Future<List<User>> getUsers() async {
    return await _fetchUsers();
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    return _users.where((user) => user.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Future<int> countUsers() async {
    return _users.length;
  }
}