import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'services/user_service.dart';
import 'repositories/local_user_repository.dart';

class MyApp extends StatelessWidget {
  final UserService userService;

// O serviço é injetado no MyApp
  const MyApp({Key? key, required this.userService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/userList',
      routes: {
        '/userList': (context) => UserListView(userService: userService),
      },
    );
  }
}

