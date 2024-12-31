import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'repositories/local_user_repository.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/user_list_viewmodel.dart';
import 'viewmodels/family_viewmodel.dart';
import 'models/mock_user_data.dart';

void main() async {
  // Inicializa o framework do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o repositório com dados mockados
  final userRepository = LocalUserRepository(initialUsers: MockUserData.users);

  // Cria a instância do FamilyViewModel
  final familyViewModel = FamilyViewModel(userRepository);

  // Inicia o aplicativo com os providers necessários
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => familyViewModel),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(userRepository, familyViewModel),
        ),
        ChangeNotifierProvider(create: (_) => UserListViewModel(userRepository)),
      ],
      child: const MyApp(),
    ),
  );
}