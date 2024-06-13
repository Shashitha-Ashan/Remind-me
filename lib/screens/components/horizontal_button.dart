import 'package:flutter/material.dart';

class HorizontalButton extends StatelessWidget {
  final String buttonName;
  const HorizontalButton({super.key, required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      elevation: 20,
      minWidth: double.infinity,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(5)),
      color: Colors.red,
      onPressed: () {},
      child: Text(
        buttonName,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
