import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../viewmodels/user_list_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final userViewModel = context.read<UserListViewModel>();
      final newUser = User(
        uid: DateTime.now().toString(),
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        createdAt: DateTime.now(),
      );

      try {
        final isAdded = await userViewModel.addUser(newUser);
        isAdded ? _showSuccessDialog() : _showSnackBar('Email já está em uso.');
      } catch (e) {
        _showSnackBar('Ocorreu um erro: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Conta Criada'),
          content: const Text('Sua conta foi criada com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Fecha o diálogo
                Navigator.pop(context); // Retorna para a tela de login
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildTextFormField(
                controller: _nameController,
                label: 'Nome',
                validator: (value) =>
                value == null || value.isEmpty ? 'Por favor, insira seu nome.' : null,
              ),
              _buildTextFormField(
                controller: _emailController,
                label: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email.';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido.';
                  }
                  return null;
                },
              ),
              _buildTextFormField(
                controller: _passwordController,
                label: 'Senha',
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha.';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: validator,
      obscureText: obscureText,
    );
  }

  Widget _buildSubmitButton() {
    return _isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
      onPressed: _register,
      child: const Text('Registrar'),
    );
  }
}