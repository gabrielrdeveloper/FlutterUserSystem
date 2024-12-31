import '../models/user.dart';

/// Interface para o repositório de usuários.
abstract class UserRepository {
  /// Adiciona um novo usuário.
  Future<void> addUser(User user);

  /// Retorna um usuário pelo UID.
  Future<User> getUser(String uid);

  /// Atualiza um usuário existente.
  Future<void> updateUser(User user);

  /// Remove um usuário pelo UID.
  Future<void> deleteUser(String uid);

  /// Retorna a lista de todos os usuários.
  Future<List<User>> getUsers();

  /// Busca usuários com base em um filtro.
  Future<List<User>> searchUsers(String query);

  /// Retorna o número total de usuários.
  Future<int> countUsers();
}