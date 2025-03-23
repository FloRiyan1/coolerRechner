class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  // Wandelt ein User-Objekt in ein Map um, um es in der Datenbank zu speichern.
  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'password': password};
  }

  // Erstellt ein User-Objekt aus einem Map, z. B. beim Abrufen aus der DB.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }
}
