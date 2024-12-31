import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_login_viewmodel.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  IconData _currentIcon = Icons.person_outline;

  final List<IconData> _iconOptions = [
    Icons.person_outline,
    Icons.face_outlined,
    Icons.sentiment_satisfied_outlined,
  ];

  void _showIconPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => IconPicker(
        icons: _iconOptions,
        onIconSelected: (icon) {
          setState(() {
            _currentIcon = icon;
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  String _formatName(String name) {
    return name
        .split(' ')
        .map((word) =>
    word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final loginViewModel = context.watch<LoginViewModel>();
    final user = loginViewModel.loggedInUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onLongPress: () => _showIconPicker(context),
                    child: Icon(
                      _currentIcon,
                      size: 120,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (user == null)
                    const Text(
                      'Nenhum usuário logado.',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  else ...[
                    Text(
                      _formatName(user.name),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  loginViewModel.logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red, width: 2),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class IconPicker extends StatelessWidget {
  final List<IconData> icons;
  final ValueChanged<IconData> onIconSelected;

  const IconPicker({
    super.key,
    required this.icons,
    required this.onIconSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: icons.map((icon) {
        return ListTile(
          leading: Icon(icon, size: 30),
          title: const Text('Escolher este ícone'),
          onTap: () => onIconSelected(icon),
        );
      }).toList(),
    );
  }
}