//Interface para definir os métodos para manipular os dados do usuário,
//como salvar, atualizar, deletar e buscar usuários. e posteriormente implementar base de dados firebase.

//future<void> é uma funcao assincrona que não retorna nada.
import '../models/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<User> getUser(String id);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
  Future<List<User>> getUsers();
}