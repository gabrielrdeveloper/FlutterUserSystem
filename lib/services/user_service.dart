import '../models/user.dart';
import '../repositories/user_repository.dart';

/// O `UserService` é responsável por implementar as regras de negócio
/// relacionadas aos usuários, utilizando o `UserRepository` para acessar
/// os dados da fonte (local ou remota).
class UserService {
  final UserRepository _repository;

  /// Cria uma instância do `UserService`, que utiliza o `UserRepository`
  /// como fonte dos dados.
  UserService(this._repository);

  /// Adiciona um usuário, verificando se ele já existe antes de salvar.
  Future<void> addUserIfNotExists(User user) async {
    final users = await _repository.getUsers();
    if (users.any((u) => u.uid == user.uid)) {
      throw Exception("User already exists");
    }
    await _repository.addUser(user);
  }

  /// Retorna uma lista de usuários ordenados pelo nome.
  Future<List<User>> getSortedUsers() async {
    final users = await _repository.getUsers();
    users.sort((a, b) => a.name.compareTo(b.name));
    return users;
  }

  /// Busca um usuário específico pelo seu `uid`.
  /// Retorna `null` caso o usuário não seja encontrado.
  Future<User?> findUserById(String uid) async {
    try {
      return await _repository.getUser(uid);
    } catch (e) {
      print('User not found: $e');
      return null;
    }
  }

  /// Deleta um usuário específico e retorna `true` se a remoção foi bem-sucedida.
  Future<bool> deleteUserById(String uid) async {
    final usersBefore = await _repository.getUsers();
    await _repository.deleteUser(uid);
    final usersAfter = await _repository.getUsers();
    return usersBefore.length > usersAfter.length;
  }
}