import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Color fillColor;
  final Color borderColor;
  final Color focusBorderColor;
  final double borderRadius;

  const DefaultTextField({
    super.key,
    this.hintText = '',
    this.labelText = '',
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.fillColor = Colors.white,
    this.borderColor = Colors.grey,
    this.focusBorderColor = Colors.red,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor, // Hintergrundfarbe
        hintText: hintText,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: focusBorderColor,
            width: 2.0,
          ), // Fokus-Farbe
        ),
      ),
    );
  }
}
