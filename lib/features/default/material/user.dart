import 'package:floor/floor.dart';

@Entity(tableName: 'users')
class User {
  @primaryKey
  final int id;
  final String name;
  final String password;

  User(this.id, this.name, this.password);
}
