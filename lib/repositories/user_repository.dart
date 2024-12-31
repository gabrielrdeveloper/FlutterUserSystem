/// O `UserRepository` é responsável por fornecer uma interface de acesso
/// aos dados do usuário, independentemente de sua origem (banco de dados local,
/// Firebase, API externa, etc.).
///
/// Ele abstrai os detalhes de implementação da camada de dados, permitindo
/// que a aplicação utilize dados sem se preocupar com a fonte.
///
/// Responsabilidades:
/// - Recuperar, criar, atualizar e deletar dados de usuários.
/// - Manter uma interface limpa e desacoplada da origem dos dados.
///
/// **Princípio:** O Repository NÃO contém lógica de negócio.
/// Ele apenas busca ou manipula os dados.
import '../models/user.dart';

abstract class UserRepository {
  /// Adiciona um novo usuário à fonte de dados.
  Future<void> addUser(User user);

  /// Retorna um usuário com base em seu identificador único (`uid`).
  Future<User> getUser(String uid);

  /// Atualiza os dados de um usuário existente.
  Future<void> updateUser(User user);

  /// Remove um usuário da fonte de dados com base no `uid`.
  Future<void> deleteUser(String uid);

  /// Retorna uma lista de todos os usuários disponíveis.
  Future<List<User>> getUsers();

  /// Busca usuários com base em um filtro (opcional).
  Future<List<User>> searchUsers(String query);

  /// Retorna o número total de usuários (opcional).
  Future<int> countUsers();
}

