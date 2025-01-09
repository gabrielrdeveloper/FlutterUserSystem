import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  List<User> _users = [];

  LocalUserRepository({List<User>? initialUsers}) {
    if (initialUsers != null && initialUsers.isNotEmpty) {
      _users = List.from(initialUsers);
    }
  }

  @override
  Future<void> addUser(User user) async {
    _users.add(user);
  }

  @override
  Future<User> getUser(String uid) async {
    return _users.firstWhere(
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
  }

  @override
  Future<int> deleteUser(String uid) async {
    _users.removeWhere((user) => user.uid == uid);
    return _users.length;
  }

  @override
  Future<List<User>> getUsers() async {
    return _users;
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    return _users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<int> countUsers() async {
    return _users.length;
  }
}