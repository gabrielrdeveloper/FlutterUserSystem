import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/family_viewmodel.dart';

class FamilyView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final familyViewModel = context.watch<FamilyViewModel>();
    final familyMembers = familyViewModel.familyMembers;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: familyMembers.length,
              itemBuilder: (context, index) {
                final member = familyMembers[index];
                return ListTile(
                  title: Text(member),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      familyViewModel.removeFamilyMember(member);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                    if (_controller.text.isNotEmpty) {
                      familyViewModel.addFamilyMember(_controller.text);
                      _controller.clear();
                    }
                  },
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}