import 'package:floor/floor.dart';
import '../material/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM users')
  Future<List<User>> getAllUsers();

  @insert
  Future<void> insertUser(User user);
}
