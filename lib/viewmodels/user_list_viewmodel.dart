import '../models/user.dart';
import '../repositories/user_repository.dart';

//The underscore (`_`) before `_userRepository` indicates that it is a private
// field in Dart. This means that `_userRepository` is intended to be used only
// within the `UserViewModel` class and not accessible from outside this class.
// This is a common practice to encapsulate the data and ensure that it is not modified
// directly from outside the class, promoting better encapsulation and data integrity.

class UserListViewModel {
  final UserRepository _userRepository;

  UserListViewModel(this._userRepository);

  Future<void> addUser(User user) async {
    try {
      await _userRepository.addUser(user);
    } catch (e) {
      // Log or handle the error
      print('Error adding user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _userRepository.updateUser(user);
    } catch (e) {
      print("Failed to update user: $e");
      rethrow;
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      await _userRepository.deleteUser(user);
    } catch (e) {
      print("Failed to delete user: $e");
      rethrow;
    }
  }

  Future<User> getUser(String id) async {
    try {
      return await _userRepository.getUser(id);
    } catch (e) {
      print("Failed to get user: $e");
      rethrow;
    }
  }

  Future<List<User>> getUsers() async {
    try {
      return await _userRepository.getUsers();
    } catch (e) {
      print("Failed to get users: $e");
      rethrow;
    }
  }
}