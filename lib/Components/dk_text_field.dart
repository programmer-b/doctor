import 'package:flutter/material.dart';

class DKTextField extends StatelessWidget {
  const DKTextField(
      {super.key,
      required this.hint,
      this.autoFocus = false,
      this.onChanged,
      this.keyboardType,
      this.obsecureText = false,
      this.suffixIcon,
      this.readOnly = false,
      this.onTap,
      this.controller,
      this.validator});
  final String hint;
  final bool autoFocus;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obsecureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      autofocus: autoFocus,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          border: const OutlineInputBorder(),
          fillColor: Colors.black12,
          filled: true,
          hintText: hint,
          alignLabelWithHint: true,
          hintStyle: const TextStyle()),
    );
  }
}
