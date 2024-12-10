//Interface para definir os métodos para manipular os dados do usuário,
//como salvar, atualizar, deletar e buscar usuários. e posteriormente implementar base de dados firebase.

//future<void> é uma funcao assincrona que não retorna nada.
abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
  Future<User> getUser(String id);
  Future<List<User>> getUsers();
}