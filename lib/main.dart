import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'repositories/local_user_repository.dart';
import 'viewmodels/auth_login_viewmodel.dart';
import 'viewmodels/user_list_viewmodel.dart';
import 'viewmodels/family_list_viewmodel.dart';
import 'models/mock_user_data.dart';

void main() async {
  // Inicializa o framework do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o repositório com dados mockados
  final userRepository = LocalUserRepository(initialUsers: MockUserData.users);

  runApp(
    MultiProvider(
      providers: [
        // Registra o UserListViewModel primeiro
        ChangeNotifierProvider(
          create: (_) => UserListViewModel(userRepository),
        ),

        // Registra o FamilyViewModel que depende do UserListViewModel
        ChangeNotifierProvider(
          create: (context) => FamilyViewModel(
            userRepository,
            context.read<UserListViewModel>(),
          ),
        ),

        // Registra o LoginViewModel que depende do FamilyViewModel
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(
            userRepository,
            context.read<FamilyViewModel>(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}