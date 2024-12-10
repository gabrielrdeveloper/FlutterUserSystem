import 'package:flutter/material.dart';
import 'app.dart';
import 'services/local_user_service.dart';
import 'models/mock_user_data.dart';

void main() {
  // Inicialize o serviço com os dados mockados
  final userService = LocalUserService(initialUsers: MockUserData.users);

  runApp(MyApp(userService: userService));
}