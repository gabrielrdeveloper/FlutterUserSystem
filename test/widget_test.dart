// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_user_system/app.dart';
import 'package:flutter_user_system/services/user_service.dart';
import 'package:flutter_user_system/repositories/local_user_repository.dart';
import 'package:flutter_user_system/models/mock_user_data.dart';

void main() {
  testWidgets('MyApp smoke test', (WidgetTester tester) async {
    // Inicializa o LocalUserRepository com os dados mockados
    final userRepository = LocalUserRepository(initialUsers: MockUserData.users);

    // Cria o UserService usando o UserRepository
    final userService = UserService(userRepository);

    // Build MyApp com a dependência UserService injetada
    await tester.pumpWidget(MyApp(userService: userService));

    // Verifica se o título da tela está sendo renderizado corretamente
    expect(find.text('User List'), findsOneWidget);

    // Verifica se os dados mockados estão na lista
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('Alice Smith'), findsOneWidget);
  });
}
