import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserService implements UserRepository {
  final List<User> _users;

  LocalUserService({List<User>? initialUsers}) : _users = initialUsers ?? [];

  //Create
  @override
  Future<void> addUser(User user) async {
    _users.add(user);
  }
  //Read
  @override
  Future<User> getUser(String id) async {
    return _users.firstWhere((user) => user.uid == id, orElse: () => throw Exception('User not found'));
  }
  //Update
  @override
  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('User not found');
    }
    _users[index] = user;
  }
  //Delete
  @override
  Future<void> deleteUser(User user) async {
    _users.remove(user);
  }
  
  //Get all users
  @override
  Future<List<User>> getUsers() async {
    return _users;
  }

}
