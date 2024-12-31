import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_list_viewmodel.dart';

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
    final users = userViewModel.users;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/register_view');
            },
          ),
        ],
      ),
      body: userViewModel.users.isEmpty
          ? const Center(child: Text('No users available.'))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final success = await userViewModel.deleteUser(user.uid);
                if (!success) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to delete user')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}