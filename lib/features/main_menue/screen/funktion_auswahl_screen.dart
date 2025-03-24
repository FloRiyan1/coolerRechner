import 'package:flutter/material.dart';

class FunktionAuswahlScreen extends StatefulWidget {
  const FunktionAuswahlScreen({super.key});

  @override
  State<FunktionAuswahlScreen> createState() => _FunktionAuswahlScreenState();
}

class _FunktionAuswahlScreenState extends State<FunktionAuswahlScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Florians Coole App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
        ],
      ),
    );
  }
}
