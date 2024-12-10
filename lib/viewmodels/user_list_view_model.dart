import '../models/user.dart';
import '../repositories/user_repository.dart';

//The underscore (`_`) before `_userRepository` indicates that it is a private
// field in Dart. This means that `_userRepository` is intended to be used only
// within the `UserViewModel` class and not accessible from outside this class.
// This is a common practice to encapsulate the data and ensure that it is not modified
// directly from outside the class, promoting better encapsulation and data integrity.

class UserViewModel {
  final UserRepository _userRepository;

  UserViewModel(this._userRepository);

  Future<void> addUser(User user) async {
    await _userRepository.addUser(user);
  }

  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
  }

  Future<void> deleteUser(User user) async {
    await _userRepository.deleteUser(user);
  }

  Future<User> getUser(String id) async {
    return await _userRepository.getUser(id);
  }

  Future<List<User>> getUsers() async {
    return await _userRepository.getUsers();
  }
}