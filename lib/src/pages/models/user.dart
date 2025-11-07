class User {
  final String id;
  final String nombre;
  final String usuario;
  final String password;
  final String email;

  User({
    required this.id,
    required this.nombre,
    required this.usuario,
    required this.password,
    required this.email
  });

  /// Convertir el producto a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'usuario': usuario,
      'password': password,
      'email': email
    };
  }

  /// Crear una instancia de Product desde un Map
  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      nombre: map['nombre'] ?? '',
      usuario: map['usuario'] ?? '',
      password: map['password'] ?? '',
      email: map['email'] ?? '',
    );
  }

  /// Crear una copia del producto con algunos campos modificados
  User copyWith({
    String? id,
    String? nombre,
    String? usuario,
    String? password,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      usuario: usuario ?? this.usuario,
      password: password ?? this.password,
      email: email ?? this.email
    );
  }
}