import 'package:flutter/material.dart';
import 'package:myapp/features/default/widgets/default_text_field.dart';
import 'package:myapp/features/default/widgets/headline_text.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(children: [HeadlineText(text: "Registrieren")]),
          const SizedBox(height: 10),
          DefaultTextField(labelText: "Username"),
          const SizedBox(height: 20),
          DefaultTextField(labelText: "Passwort"),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {}, child: const Text('Register')),
        ],
      ),
    );
  }
}
