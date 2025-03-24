import 'package:flutter/material.dart';
import 'package:myapp/features/default/widgets/default_text.dart';
import 'package:myapp/features/authentication/widget/login_widget.dart';
import 'package:myapp/features/authentication/widget/register_widget.dart';

import '../widget/login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Florians Coole App')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [LoginWidget()],
        ),
    );
  }
}
