import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  user? loggedInUser;

  void login(User user) {
    loggedInUser = user;
    notifyListeners();
  }

  void loginAnonymously() {
    loggedInUser = null;
    notifyListeners();
  }

  void logout() {
    loggedInUser = null;
    notifyListeners();
  }

  bool get isAnonymous => loggedInUser == null;

}