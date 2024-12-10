class User {
  final String uid;
  final String name;
  final String email;

  User({
    required this.uid,
    required this.name,
    required this.email,
  });

  // Metodo opcional para converter para JSON, útil para Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

  // Metodo opcional para criar um User a partir de JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
    );
  }
}