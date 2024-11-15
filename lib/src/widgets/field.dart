import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  final Size size;
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;

  const Field({
    super.key,
    required this.size,
    required this.icon,
    required this.hintText,
    required this.controller, required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 15,
      width: size.width / 1.1,
      child: TextField(
        obscureText: isPassword,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
