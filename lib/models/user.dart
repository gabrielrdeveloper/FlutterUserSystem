import 'package:equatable/equatable.dart';

/// Modelo que representa os dados de um Usuário.
/// Inclui informações principais como UID, nome, email, senha, membros da família e data de criação.
class User extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String? password;
  final List<String> familyMembers;
  final DateTime createdAt; // Data de criação do usuário

  /// Construtor do modelo de Usuário.
  const User({
    required this.uid,
    required this.name,
    required this.email,
    this.password,
    this.familyMembers = const [],
    required this.createdAt,
  });

  /// Serializa um objeto [User] para um Map (JSON).
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'familyMembers': familyMembers,
      'createdAt': createdAt.toIso8601String(), // Serializa como string ISO 8601
    };
  }

  /// Cria uma instância de [User] a partir de um Map (JSON).
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      familyMembers: (json['familyMembers'] as List<dynamic>?)?.cast<String>() ?? [],
      createdAt: DateTime.parse(json['createdAt']), // Converte string ISO para DateTime
    );
  }

  /// Lista de propriedades utilizadas para comparar instâncias de [User].
  @override
  List<Object?> get props => [uid, name, email, password, familyMembers, createdAt];

  /// Valida se os campos obrigatórios do modelo [User] estão preenchidos corretamente.
  bool get isValid => uid.isNotEmpty && name.isNotEmpty && email.contains('@');

  /// Cria uma cópia do objeto [User] com alterações opcionais.
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