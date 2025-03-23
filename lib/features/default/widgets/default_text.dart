import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  final String text;

  const DefaultText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
