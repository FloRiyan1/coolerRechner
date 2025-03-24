class User {
  final int? id;
  final String username;
  final String password;

  User({this.id, required this.username, required this.password});

  // Wandelt ein User-Objekt in ein Map um, um es in der Datenbank zu speichern.
  Map<String, dynamic> toMap() {
    final map = {'username': username, 'password': password};
    if (id != null) {
      map['id'] = id as String;
    }
    return map;
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
