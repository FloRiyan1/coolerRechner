import 'package:flutter/material.dart';
import 'package:myapp/features/authentication/material/user.dart';
import 'package:myapp/features/default/data_access_object/dao.dart';
import 'package:myapp/features/default/widgets/default_text_field.dart';
import 'package:myapp/features/default/widgets/headline_text.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(BuildContext context) async {
    List<User> users = await Dao.instance.getUsers();
    for (User user in users) {
      if (user.username == _usernameController.text &&
          user.password == _passwordController.text) {
        Navigator.pushNamed(context, '/register');
        return; // Stoppe nach erfolgreicher Anmeldung
      }
    }
    // Optional: Fehler anzeigen, wenn keine Übereinstimmung gefunden wurde
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ungültige Anmeldedaten")),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            color: Colors.black.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(children: [HeadlineText(text: "Anmelden")]),
          const SizedBox(height: 10),
          DefaultTextField(
            labelText: "Username",
            controller: _usernameController,
          ),
          const SizedBox(height: 20),
          DefaultTextField(
            labelText: "Passwort",
            controller: _passwordController,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Zum Registrieren'),
              ),
              ElevatedButton(
                onPressed: () => login(context),
                child: const Text('Anmelden'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
