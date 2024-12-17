import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'services/user_service.dart';
import 'repositories/local_user_repository.dart';

class MyApp extends StatelessWidget {
  final UserService userService;

// O servico é injetado no MyApp
  const MyApp({super.key, required this.userService});

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

