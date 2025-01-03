import 'package:flutter/material.dart';
import 'views/user/user_list_view.dart';
import 'views/auth/auth_login_view.dart';
import 'views/auth/auth_register_view.dart';
import 'views/maintabbar.dart';

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
        '/login': (context) => LoginView(),
        '/register_view': (context) => RegisterView(),
        '/userList': (context) => MainTabBar(),
      },
    );
  }
}