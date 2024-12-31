import 'package:equatable/equatable.dart';

/// Classe que representa o modelo de dados do Usuário.
/// Contém os atributos principais e métodos de serialização.
class User extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? password;
  final List<String> familyMembers;
  final DateTime createdAt; // Adicionado para armazenar a data de criação

  const User({
    required this.uid,
    required this.name,
    required this.email,
    this.password,
    this.familyMembers = const [],
    required this.createdAt, // Torna obrigatório
  });

  /// Converte um User para um Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'familyMembers': familyMembers,
      'createdAt': createdAt.toIso8601String(), // Salva como ISO string
    };
  }

  /// Cria um User a partir de um Map (JSON)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      familyMembers: (json['familyMembers'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt']), // Converte de string para DateTime
    );
  }

  /// Propriedades usadas para comparar igualdade entre objetos `User`.
  @override
  List<Object?> get props => [uid, name, email, password, familyMembers, createdAt];

  /// Validação básica do modelo
  bool get isValid => uid.isNotEmpty && name.isNotEmpty && email.contains('@');

  /// Metodo para criar uma cópia de um objeto com alterações específicas
  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    List<String>? familyMembers,
    DateTime? createdAt,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      familyMembers: familyMembers ?? this.familyMembers,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}