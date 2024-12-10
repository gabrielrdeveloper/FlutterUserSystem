import '../models/user.dart';

class MockUserData {
  static final List<User> users = [
    User(uid: '1', name: 'John Doe', email: 'john@example.com'),
    User(uid: '2', name: 'Jane Doe', email: 'jane@example.com'),
    User(uid: '3', name: 'Alice Smith', email: 'alice@example.com'),
  ];
}