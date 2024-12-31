import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/family_list_viewmodel.dart';

class FamilyView extends StatelessWidget {
  FamilyView({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final familyViewModel = context.watch<FamilyViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Familiares')),
      body: Column(
        children: [
          Expanded(
            child: _buildFamilyList(familyViewModel),
          ),
          _buildInputSection(familyViewModel),
        ],
      ),
    );
  }

  Widget _buildFamilyList(FamilyViewModel familyViewModel) {
    final familyMembers = familyViewModel.familyMembers;

    if (familyMembers.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum familiar adicionado.',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      );
    }

    return ListView.builder(
      itemCount: familyMembers.length,
      itemBuilder: (context, index) {
        final member = familyMembers[index];
        return _buildFamilyMemberTile(member, familyViewModel);
      },
    );
  }

  Widget _buildFamilyMemberTile(String member, FamilyViewModel familyViewModel) {
    return ListTile(
      title: Text(member),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () {
          familyViewModel.removeFamilyMember(member);
        },
      ),
    );
  }

  Widget _buildInputSection(FamilyViewModel familyViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Novo Familiar'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final inputText = _controller.text.trim();
              if (inputText.isNotEmpty) {
                familyViewModel.addFamilyMember(inputText);
                _controller.clear();
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}