import '../models/user.dart';

class MockUserData {
  static final List<User> users = [
    User(uid: '1', name: 'John Doe', email: 'john@example.com', password: '123456', familyMembers: ['Jane Doe']),
    User(uid: '2', name: 'Jane Doe', email: 'jane@example.com', password: '123456', familyMembers: ['John Doe']),
    User(uid: '3', name: 'Alice Smith', email: 'alice@example.com', password: '123456', familyMembers: ['Bob Smith', 'Eve Smith']),
    User(uid: '4', name: 'Bob Smith', email: 'bob@example.com', password: '123456', familyMembers: ['Alice Smith']),
    User(uid: '5', name: 'Eve Smith', email: 'eve@example.com', password: '123456', familyMembers: ['Alice Smith']),
    User(uid: '6', name: 'Charlie Brown', email: 'charlie@example.com', password: '123456', familyMembers: ['Snoopy']),
    User(uid: '7', name: 'Lucy van Pelt', email: 'lucy@example.com', password: '123456', familyMembers: ['Linus van Pelt']),
    User(uid: '8', name: 'Linus van Pelt', email: 'linus@example.com', password: '123456', familyMembers: ['Lucy van Pelt']),
    User(uid: '9', name: 'Peppermint Patty', email: 'patty@example.com', password: '123456', familyMembers: ['James jones Patty']),
    User(uid: '10', name: 'Snoopy', email: 'snoopy@example.com', password: '123456', familyMembers: ['Charlie Brown']),
  ];
}