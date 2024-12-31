import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtém o usuário logado da LoginViewModel
    final loginViewModel = context.watch<LoginViewModel>();
    final user = loginViewModel.loggedInUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (user == null)
              const Text(
                'Nenhum usuário logado.',
                style: TextStyle(fontSize: 18),
              )
            else ...[
              Text('Nome: ${user.name}', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            ],
            const Spacer(), // Empurra o botão para o final da tela
            ElevatedButton(
              onPressed: () {
                // Executa o logout
                loginViewModel.logout();

                // Navega para a tela de login
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}