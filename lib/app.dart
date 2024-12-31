import 'package:flutter/material.dart';
import 'views/user_list_view.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register_view': (context) => const RegisterView(),
        '/userList': (context) => const UserListView(),
      },
    );
  }
}