import 'package:flutter/material.dart';
import 'app.dart';
import 'services/user_service.dart';
import 'repositories/local_user_repository.dart';
import 'models/mock_user_data.dart';

void main() {
  // Inicializa o LocalUserRepository com os dados mockados
  final userRepository = LocalUserRepository(initialUsers: MockUserData.users);

  // Cria o UserService usando o UserRepository
  final userService = UserService(userRepository);

  runApp(MyApp(userService: userService));
}