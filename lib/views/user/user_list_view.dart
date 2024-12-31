import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/user_list_viewmodel.dart';
import '../../viewmodels/auth_login_viewmodel.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  void initState() {
    super.initState();
    // Carrega os usuários ao iniciar a tela
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserListViewModel>().loadUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserListViewModel>();
    final loginViewModel = context.watch<LoginViewModel>();
    final loggedInUser = loginViewModel.loggedInUser;
    final users = userViewModel.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar por nome',
                border: OutlineInputBorder(),
              ),
              onChanged: userViewModel.searchUsers,
            ),
          ),
          Expanded(
            child: users.isEmpty
                ? const Center(child: Text('Nenhum usuário disponível ou encontrado.'))
                : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isFamiliar = loggedInUser?.familyMembers.contains(user.name) ?? false;

                return UserTile(
                  name: user.name,
                  email: user.email,
                  isFamiliar: isFamiliar,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget para representar cada usuário na lista
class UserTile extends StatelessWidget {
  final String name;
  final String email;
  final bool isFamiliar;

  const UserTile({
    super.key,
    required this.name,
    required this.email,
    required this.isFamiliar,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      trailing: Text(isFamiliar ? 'Familiar' : 'Cliente'),
    );
  }
}