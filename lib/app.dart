import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'services/local_user_service.dart';
import 'models/mock_user_data.dart';

class MyApp extends StatelessWidget {
  final LocalUserService userService;

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

