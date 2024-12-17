import 'package:equatable/equatable.dart';

/// Classe que representa o modelo de dados do Usuário.
/// Contém os atributos principais e métodos de serialização.
class User extends Equatable {
  final String uid;
  final String name;
  final String email;

  const User({
    required this.uid,
    required this.name,
    required this.email,
  });

  /// Metodo opcional para converter o objeto `User` em um mapa JSON.
  /// Útil para integração com bancos de dados como Firebase Firestore.
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  /// Factory que cria um objeto `User` a partir de um mapa JSON.
  /// Útil para desserialização de dados vindos de um banco ou API.
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  // Metodo toString sobrescrito para fornecer uma representação textual do objeto.
  /// Útil para debugging e logs.
  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email)';
  }

  /// Propriedades usadas para comparar igualdade entre objetos `User`.
  /// Implementa o `Equatable` para facilitar comparações.
  @override
  List<Object?> get props => [uid, name, email];
}