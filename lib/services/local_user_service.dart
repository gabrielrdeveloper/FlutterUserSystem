import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserService implements UserRepository {
  final List<User> _users = [];

  @override
  Future<void> addUser(User user) async {
    _users.add(user);
  }

  @override
  Future<void> deleteUser(User user) async {
    _users.remove(user);
  }

  @override
  Future<User> getUser(String id) async {
    return _users.firstWhere((user) => user.uid == id);
  }

  @override
  Future<List<User>> getUsers() async {
    return _users;
  }

}
