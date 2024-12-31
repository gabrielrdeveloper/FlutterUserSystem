import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/user_list_viewmodel.dart';

class UserListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserListViewModel>();
    final users = userViewModel.users;

    return Scaffold(
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Buscar usuário'),
            onChanged: (query) {
              userViewModel.searchUsers(query);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final isFamiliar = userViewModel.loggedInUser?.familyMembers.contains(user.name) ?? false;

                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: Text(isFamiliar ? 'Familiar' : 'Cliente'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}