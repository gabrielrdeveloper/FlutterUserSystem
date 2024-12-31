import 'package:flutter/material.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';

class FamilyViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  List<String> _familyMembers = [];
  List<String> get familyMembers => _familyMembers;

  User? _loggedInUser;

  FamilyViewModel(this._userRepository);

  /// Configura o usuário logado
  void setLoggedInUser(User user) {
    _loggedInUser = user;
    _familyMembers = user.familyMembers;
    notifyListeners();
  }

  /// Adiciona um novo familiar
  Future<void> addFamilyMember(String name) async {
    if (_loggedInUser == null) return;

    try {
      _familyMembers.add(name);

      // Atualiza o usuário no repositório
      final updatedUser = _loggedInUser!.copyWith(familyMembers: _familyMembers);
      await _userRepository.updateUser(updatedUser);

      _loggedInUser = updatedUser;
      notifyListeners();
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

      _loggedInUser = updatedUser;
      notifyListeners();
    } catch (e) {
      print("Failed to remove family member: $e");
    }
  }

  /// Limpa os familiares ao fazer logout
  void clearFamilyMembers() {
    _familyMembers = [];
    notifyListeners();
  }
}