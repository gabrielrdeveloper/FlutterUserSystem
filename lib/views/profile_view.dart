import 'package:flutter/material.dart';
import '../models/user.dart';

class ProfileView extends StatelessWidget {
  final User? user;

  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Center(child: Text('Nenhum usuário logado.'));
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nome: ${user.name}', style: const TextStyle(fontSize: 18)),
          Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}