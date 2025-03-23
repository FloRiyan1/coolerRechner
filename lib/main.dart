import 'package:flutter/material.dart';
import 'package:myapp/features/default/data_access/data_access_object.dart';
import 'package:myapp/features/login/screen/register_screen.dart';

import 'features/default/material/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Datenbank erstellen und initialisieren
  final database = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();
  final userDao = database.userDao;

  // Beispiel: Einen neuen Nutzer einfügen
  await userDao.insertUser(User(1, 'Florian','test'));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
    );
  }
}
