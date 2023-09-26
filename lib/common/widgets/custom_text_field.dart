import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final int maxLines;
  final VoidCallback? onChangeVisibilityPress;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.icon,
    this.onChangeVisibilityPress,
    this.obscureText = false,
    required this.hintText,
    this.maxLines = 1,
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
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          icon: Icon(icon),
          onPressed: onChangeVisibilityPress,
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
