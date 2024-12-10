import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  final List<User> _users = [];

  @override
  Future<void> addUser(User user) async {
    _users.add(user);
  }

  @override
  Future<User> getUser(String uid) async {
    return _users.firstWhere((user) => user.uid == uid, orElse: () => throw Exception('User not found'));
  }

  @override
  Future<void> updateUser(User user) async {
    int index = _users.indexWhere((u) => u.uid == user.uid);
    if (index != -1) {
      _users[index] = user;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> deleteUser(User user) async {
    _users.removeWhere((u) => u.uid == user.uid);
  }

  @override
  Future<List<User>> getUsers() async {
    return _users;
  }
}