import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_list_view.dart';
import 'family_view.dart';
import '../viewmodels/login_viewmodel.dart';

class MainTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();
    final user = loginViewModel.loggedInUser;

    return DefaultTabController(
      length: 3, // Número de abas
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerenciamento de Usuários'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Perfil'),
              Tab(icon: Icon(Icons.list), text: 'Usuários'),
              Tab(icon: Icon(Icons.family_restroom), text: 'Familiares'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Aba 1: Lista de Usuários
            UserListView(),
            // Aba 3: Meus Familiares
            FamilyView(),
            // Aba 3: Perfil
            ProfileView(user: user),
          ],
        ),
      ),
    );
  }
}