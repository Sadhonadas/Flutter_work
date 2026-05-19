import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String hintText;
  final String labelText;
  final Icon prefixIcon;
  final bool obscureText;

  
  const InputField({super.key,
                    required this.controller,
                   required this.keyboardType,
                   required this.validator,
                   required this.hintText,
                   required this.labelText,
                   required this.prefixIcon,
                   this.obscureText = false,
  });

  @override
Widget build(BuildContext context) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    validator: validator,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
}