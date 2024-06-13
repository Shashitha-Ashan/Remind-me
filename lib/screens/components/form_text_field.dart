import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController textEditingController;
  const FormTextField({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: hintText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
