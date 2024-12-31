import 'package:flutter/material.dart';
import 'user/user_list_view.dart';
import 'family/family_list_view.dart';
import 'user/user_profile_view.dart';

class MainTabBar extends StatelessWidget {
  const MainTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerenciamento de Usuários'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Usuários'),
              Tab(icon: Icon(Icons.family_restroom), text: 'Familiares'),
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserListView(),
            FamilyView(),
            ProfileView(),
          ],
        ),
      ),
    );
  }
}