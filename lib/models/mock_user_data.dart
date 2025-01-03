import '../models/user.dart';

/// Mock de dados para usuários, usado em testes ou inicializações.
class MockUserData {
  /// Lista de usuários simulados com dados pré-definidos.
  static final List<User> users = [
    User(
      uid: '1',
      name: 'John Doe',
      email: 'john@example.com',
      password: '123456',
      familyMembers: ['Jane Doe'],
      createdAt: DateTime.parse('2022-01-01T10:00:00'),
    ),
    User(
      uid: '2',
      name: 'Jane Doe',
      email: 'jane@example.com',
      password: '123456',
      familyMembers: ['John Doe'],
      createdAt: DateTime.parse('2022-02-01T11:30:00'),
    ),
    User(
      uid: '3',
      name: 'Alice Smith',
      email: 'alice@example.com',
      password: '123456',
      familyMembers: ['Bob Smith', 'Eve Smith'],
      createdAt: DateTime.parse('2022-03-15T14:45:00'),
    ),
    User(
      uid: '4',
      name: 'Bob Smith',
      email: 'bob@example.com',
      password: '123456',
      familyMembers: ['Alice Smith'],
      createdAt: DateTime.parse('2022-03-20T08:20:00'),
    ),
    User(
      uid: '5',
      name: 'Eve Smith',
      email: 'eve@example.com',
      password: '123456',
      familyMembers: ['Alice Smith'],
      createdAt: DateTime.parse('2022-04-10T16:10:00'),
    ),
    User(
      uid: '6',
      name: 'Charlie Brown',
      email: 'charlie@example.com',
      password: '123456',
      familyMembers: ['Snoopy'],
      createdAt: DateTime.parse('2022-05-05T18:00:00'),
    ),
    User(
      uid: '7',
      name: 'Lucy van Pelt',
      email: 'lucy@example.com',
      password: '123456',
      familyMembers: ['Linus van Pelt'],
      createdAt: DateTime.parse('2022-06-01T09:10:00'),
    ),
    User(
      uid: '8',
      name: 'Linus van Pelt',
      email: 'linus@example.com',
      password: '123456',
      familyMembers: ['Lucy van Pelt'],
      createdAt: DateTime.parse('2022-06-05T12:15:00'),
    ),
    User(
      uid: '9',
      name: 'Peppermint Patty',
      email: 'patty@example.com',
      password: '123456',
      familyMembers: ['James Jones Patty'],
      createdAt: DateTime.parse('2022-07-10T15:30:00'),
    ),
    User(
      uid: '10',
      name: 'Snoopy',
      email: 'snoopy@example.com',
      password: '123456',
      familyMembers: ['Charlie Brown', 'Woodstock'],
      createdAt: DateTime.parse('2022-08-01T08:00:00'),
    ),
  ];
}