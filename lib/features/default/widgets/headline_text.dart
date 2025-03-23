import 'package:flutter/material.dart';
import 'package:myapp/features/default/style/default_test_style.dart';

class HeadlineText extends StatelessWidget {
  final String text;

  const HeadlineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: DefaultTextStyles.headline);
  }
}
