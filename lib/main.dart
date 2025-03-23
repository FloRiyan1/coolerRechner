import 'package:flutter/material.dart';
import 'package:myapp/features/login/screen/register_screen.dart';
import 'features/default/data_access_object/dao.dart';

Future<void> main() async {
  initDatabase();
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
