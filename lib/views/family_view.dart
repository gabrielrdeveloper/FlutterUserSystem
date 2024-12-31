class FamilyView extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final familyViewModel = context.watch<FamilyViewModel>();

    if (familyViewModel.loggedInUser == null) {
      return const Center(child: Text("Você precisa estar logado para usar essa funcionalidade."));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Meus Familiares')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: familyViewModel.familyMembers.length,
              itemBuilder: (context, index) {
                final member = familyViewModel.familyMembers[index];
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