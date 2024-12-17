import '../models/user.dart';
import '../repositories/user_repository.dart';

class UserListViewModel {
  final UserRepository _userRepository;

  UserListViewModel(this._userRepository);

  Future<bool> addUser(User user) async {
    try {
      await _userRepository.addUser(user);
      return true;
    } catch (e) {
      print('Error adding user: $e');
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user);
      return true;
    } catch (e) {
      print("Failed to update user: $e");
      return false;
    }
  }

  Future<bool> deleteUser(User user) async {
    try {
      await _userRepository.deleteUser(user.uid);
      return true;
    } catch (e) {
      print("Failed to delete user: $e");
      return false;
    }
  }

  Future<User?> getUser(String id) async {
    try {
      return await _userRepository.getUser(id);
    } catch (e) {
      print("Failed to get user: $e");
      return null;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      return await _userRepository.getUsers();
    } catch (e) {
      print("Failed to get users: $e");
      return [];
    }
  }
}