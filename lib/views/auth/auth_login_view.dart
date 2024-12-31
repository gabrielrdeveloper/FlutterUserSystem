import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_login_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final password = _passwordController.text;
      final loginViewModel = context.read<LoginViewModel>();

      try {
        await loginViewModel.login(email, password);
        if (loginViewModel.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loginViewModel.errorMessage!)),
          );
        } else {
          Navigator.pushReplacementNamed(context, '/userList');
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _anonymousLogin() {
    final loginViewModel = context.read<LoginViewModel>();
    loginViewModel.loginAnonymously();
    Navigator.pushReplacementNamed(context, '/userList');
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: const Icon(Icons.lock, size: 150, color: Colors.blue),
              ),
            ),
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu email';
                          }
                          if (!loginViewModel.isEmailValid(value)) {
                            return 'Por favor, insira um email válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          if (!loginViewModel.isPasswordValid(value)) {
                            return 'A senha deve ter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else ...[
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register_view'),
                      child: const Text('Não tem uma conta? Cadastre-se'),
                    ),
                    const Spacer(),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _anonymousLogin,
                      child: const Text('Entrar como visitante'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}