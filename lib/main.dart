import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'repositories/local_user_repository.dart';
import 'viewmodels/user_list_viewmodel.dart';
import 'models/mock_user_data.dart';

void main() async {
  // Inicializa o framework do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o repositório e a ViewModel
  final userRepository = LocalUserRepository(initialUsers: MockUserData.users);
  final userListViewModel = UserListViewModel(userRepository);

  // Inicia o aplicativo
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userListViewModel),
      ],
      child: const MyApp(),
    ),
  );
}