import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextFormField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if(value == null||value.isEmpty){
          return "Enter your $hintText";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 20
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        ),
        enabledBorder:  const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38)
        ),
      ),
    );
  }
}
