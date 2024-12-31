import 'package:flutter/cupertino.dart';

class FamilyViewModel extends ChangeNotifier {
  List<String> familyMembers = [];

  void addFamilyMember(String name) {
    familyMembers.add(name);
    notifyListeners();
  }

  void removeFamilyMember(String name) {
    familyMembers.remove(name);
    notifyListeners();
  }
}