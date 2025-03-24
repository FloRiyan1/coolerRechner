import 'package:flutter/material.dart';
import 'package:myapp/features/default/widgets/default_text_field.dart';
import 'package:myapp/features/default/widgets/headline_text.dart';
import '../../default/data_access_object/dao.dart';
import '../material/user.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    List<User> users = await Dao.instance.getUsers();
    bool usernameExists = users.any((user) => user.username == _usernameController.text);
    if (usernameExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username existiert bereits")),
      );
    } else {
      User newUser = User(
        username: _usernameController.text,
        password: _passwordController.text,
      );
      await Dao.instance.insertUser(newUser);
      Navigator.pushNamed(context, '/login');
    }
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
          const Row(children: [HeadlineText(text: "Registrieren")]),
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
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Zum Login'),
              ),
              ElevatedButton(
                onPressed: () => register(context),
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
