import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      this.keyboardType,
      this.preicon,
      this.sufficon,
      this.validator,
      required this.onChanged,
      this.hint,
      this.obscureText = false});
  final String label;
  final bool obscureText;
  final String? hint;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final Icon? preicon;
  final IconButton? sufficon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: 1,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        label: Text(label),
        suffixIcon: sufficon,
        prefixIcon: preicon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
