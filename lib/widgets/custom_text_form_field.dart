import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hint;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;

  CustomTextFormField({
    this.controller,
    this.obscureText = false,
    this.hint,
    this.validator,
    this.onSaved,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hint,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
