import 'package:flutter/material.dart';
import 'package:flutter_user_system/viewmodels/user_list_viewmodel.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class FamilyViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  final UserListViewModel _userListViewModel;

  List<String> _familyMembers = [];
  List<String> get familyMembers => _familyMembers;

  User? _loggedInUser;

  FamilyViewModel(this._userRepository, this._userListViewModel);

  /// Define o usuário logado e carrega os familiares associados
  void setLoggedInUser(User user) {
    _loggedInUser = user;
    _familyMembers = List.from(user.familyMembers);
    notifyListeners();
    print("[FamilyViewModel] Usuário logado configurado: ${user.name}");
  }

  /// Adiciona um novo familiar
  Future<void> addFamilyMember(String name) async {
    if (_loggedInUser == null || name.isEmpty) return;

    // Verifica se o familiar já existe
    if (_familyMembers.contains(name)) {
      print("[FamilyViewModel] Familiar já existe: $name");
      return;
    }

    try {
      _familyMembers.add(name);

      // Cria o novo familiar como usuário
      final newFamilyUser = User(
        uid: DateTime.now().toString(),
        name: name,
        email: "$name@example.com",
        password: "123456",
        createdAt: DateTime.now(),
      );

      await _userRepository.addUser(newFamilyUser);

      // Atualiza o usuário logado com o novo familiar
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);
      _loggedInUser = updatedUser;

      notifyListeners();
      print("[FamilyViewModel] Familiar adicionado com sucesso: $name");
    } catch (e) {
      print("[FamilyViewModel] Erro ao adicionar familiar: $e");
    }
  }

  /// Remove um familiar
  Future<void> removeFamilyMember(String name) async {
    if (_loggedInUser == null || !_familyMembers.contains(name)) return;

    try {
      _familyMembers.remove(name);

      // Atualiza o usuário logado
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);
      _loggedInUser = updatedUser;

      // Remove o familiar do sistema, se existir
      final allUsers = await _userRepository.getUsers();
      final userToRemove = allUsers.firstWhere(
            (user) => user.name == name,
        orElse: () => User(
          uid: '',
          name: '',
          email: '',
          password: '',
          createdAt: DateTime.now(),
        ),
      );

      // Verifica se o usuário encontrado é válido antes de removê-lo
      if (userToRemove.uid.isNotEmpty) {
        await _userRepository.deleteUser(userToRemove.uid);
        print("[FamilyViewModel] Familiar removido do sistema: $name");
      } else {
        print("[FamilyViewModel] Familiar não encontrado no sistema: $name");
      }

      notifyListeners();
    } catch (e) {
      print("[FamilyViewModel] Erro ao remover familiar: $e");
    }
  }

  /// Limpa os familiares ao deslogar
  void clearFamilyMembers() {
    _familyMembers = [];
    notifyListeners();
    print("[FamilyViewModel] Familiares limpos ao deslogar.");
  }
}