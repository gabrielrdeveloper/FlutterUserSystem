import '../models/user.dart';
import '../repositories/user_repository.dart';

class LocalUserRepository implements UserRepository {
  final List<User> _users;

  // Construtor opcional que aceita dados iniciais.
  LocalUserRepository({List<User>? initialUsers}) : _users = initialUsers ?? [];

  /// Adiciona um usuário diretamente na lista.
  @override
  Future<void> addUser(User user) async {
    _users.add(user);
  }

  /// Retorna um usuário com base no `uid`.
  /// Lança uma exceção se o usuário não for encontrado.
  @override
  Future<User> getUser(String uid) async {
    return _users.firstWhere(
          (user) => user.uid == uid,
      orElse: () => throw Exception('User not found'),
    );
  }

  /// Atualiza os dados de um usuário existente.
  @override
  Future<void> updateUser(User user) async {
    final index = _users.indexWhere((u) => u.uid == user.uid);
    if (index == -1) {
      throw Exception('User not found');
    }
    _users[index] = user;
  }

  @override
  Future<bool> deleteUser(String uid) async {
    final int initialLength = _users.length;
    _users.removeWhere((user) => user.uid == uid);
    return _users.length < initialLength;
  }

  /// Retorna todos os usuários armazenados.
  @override
  Future<List<User>> getUsers() async {
    return _users;
  }
}