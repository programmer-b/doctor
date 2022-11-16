import 'package:flutter/material.dart';

class DKPasswordToggle extends StatelessWidget {
  const DKPasswordToggle({super.key, required this.visible, this.onPressed});
  final bool visible;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Icon(visible ? Icons.visibility : Icons.visibility_off));
  }
}
