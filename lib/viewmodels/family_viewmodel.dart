import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'user_list_viewmodel.dart';

class FamilyViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final UserListViewModel _userListViewModel;

  List<String> _familyMembers = [];
  List<String> get familyMembers => _familyMembers;

  User? _loggedInUser;

  FamilyViewModel(this._userRepository, this._userListViewModel);

  /// Configura o usuário logado
  void setLoggedInUser(User user) {
    _loggedInUser = user;
    _familyMembers = user.familyMembers;
    notifyListeners();
    print("[FamilyViewModel] Usuário logado configurado: ${user.name}");
    print("[FamilyViewModel] Familiares carregados: $_familyMembers");
  }

  /// Adiciona um novo familiar
  Future<void> addFamilyMember(String name) async {
    if (_loggedInUser == null) return;

    try {
      print("[FamilyViewModel] Adicionando familiar: $name");
      _familyMembers.add(name);

      // Cria o novo familiar como um usuário no sistema
      final newFamilyUser = User(
        uid: DateTime.now().toString(),
        name: name,
        email: "$name@example.com",
        password: "123456",
        createdAt: DateTime.now(),
      );
      await _userRepository.addUser(newFamilyUser);
      _userListViewModel.addUser(newFamilyUser);

      // Atualiza o usuário no repositório
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);

      _loggedInUser = updatedUser;
      notifyListeners();

      print("[FamilyViewModel] Familiar adicionado e atualizado no repositório.");
    } catch (e) {
      print("[FamilyViewModel] Falha ao adicionar familiar: $e");
    }
  }

  /// Remove um familiar
  Future<void> removeFamilyMember(String name) async {
    if (_loggedInUser == null) return;

    try {
      print("[FamilyViewModel] Removendo familiar: $name");

      // Remove o nome do familiar da lista local
      _familyMembers.remove(name);

      // Remove o usuário correspondente do repositório e da lista geral
      final allUsers = await _userRepository.getUsers();
      final userToRemove = allUsers.firstWhere(
            (user) => user.name == name,
        orElse: () {
          print("[FamilyViewModel] Familiar não encontrado na lista geral.");
          throw Exception("Familiar não encontrado");
        },
      );

      await _userRepository.deleteUser(userToRemove.uid);
      _userListViewModel.removeUserById(userToRemove.uid);

      // Atualiza o usuário logado no repositório
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);

      _loggedInUser = updatedUser;
      notifyListeners();

      print("[FamilyViewModel] Familiar removido e atualizado no repositório.");
    } catch (e) {
      print("[FamilyViewModel] Falha ao remover familiar: $e");
    }
  }

  /// Limpa os familiares ao fazer logout
  void clearFamilyMembers() {
    _familyMembers = [];
    notifyListeners();
    print("[FamilyViewModel] Familiares limpos ao deslogar.");
  }
}