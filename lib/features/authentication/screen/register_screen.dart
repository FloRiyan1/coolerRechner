import 'package:flutter/material.dart';
import 'package:myapp/features/authentication/widget/register_widget.dart';

import '../widget/register_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Florians Coole App')),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [RegisterWidget()],
        ),
      );
  }
}
