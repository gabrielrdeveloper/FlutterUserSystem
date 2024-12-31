import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class FamilyViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  // Familiares do usuário logado
  List<String> _familyMembers = [];
  List<String> get familyMembers => _familyMembers;

  // Usuário logado
  User? _loggedInUser;
  User? get loggedInUser => _loggedInUser;

  FamilyViewModel(this._userRepository);

  /// Carrega os familiares do usuário logado
  Future<void> loadFamilyMembers() async {
    if (_loggedInUser == null) return;

    try {
      // Carrega os dados do usuário logado a partir do repositório
      final user = await _userRepository.getUser(_loggedInUser!.uid);
      _familyMembers = user.familyMembers;
      notifyListeners(); // Atualiza a interface
    } catch (e) {
      print("Failed to load family members: $e");
      _familyMembers = [];
    }
  }

  /// Configura o usuário logado e carrega os familiares
  Future<void> setLoggedInUser(User user) async {
    _loggedInUser = user;
    await loadFamilyMembers(); // Carrega os familiares do usuário logado
  }

  /// Adiciona um novo familiar
  Future<void> addFamilyMember(String name) async {
    if (_loggedInUser == null) return;

    try {
      _familyMembers.add(name);

      // Atualiza o usuário no repositório
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);

      // Atualiza o estado local do usuário logado
      _loggedInUser = updatedUser;
      notifyListeners(); // Atualiza a interface
    } catch (e) {
      print("Failed to add family member: $e");
    }
  }

  /// Remove um familiar
  Future<void> removeFamilyMember(String name) async {
    if (_loggedInUser == null) return;

    try {
      _familyMembers.remove(name);

      // Atualiza o usuário no repositório
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);

      // Atualiza o estado local do usuário logado
      _loggedInUser = updatedUser;
      notifyListeners(); // Atualiza a interface
    } catch (e) {
      print("Failed to remove family member: $e");
    }
  }

  /// Desloga o usuário e limpa os dados
  void logout() {
    _loggedInUser = null;
    _familyMembers = [];
    notifyListeners();
  }
}