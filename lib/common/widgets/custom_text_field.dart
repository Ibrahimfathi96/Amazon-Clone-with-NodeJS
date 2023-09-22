import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final VoidCallback? onChangeVisibiltyPress;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.icon,
    this.onChangeVisibiltyPress,
    this.obscureText = false,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: onChangeVisibiltyPress,
        ),
        hintStyle: const TextStyle(fontSize: 20),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
    );
  }
}
