import 'package:floor/floor.dart';
import '../material/user.dart';
import 'user_dao.dart';
import 'dart:async';

part 'app_database.g.dart'; // Generierte Datei

@Database(version: 1, entities: [User])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
