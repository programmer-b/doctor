import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKButtonComponent extends StatelessWidget {
  const DKButtonComponent(
      {super.key,
      required this.onTap,
      this.gradient,
      required this.text,
      this.width,
      this.height,
      this.isMin});

  final Function() onTap;
  final LinearGradient? gradient;
  final String text;
  final double? width;
  final double? height;
  final bool? isMin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isMin ?? false ? 35 : height ?? 50,
        width: isMin ?? false ? 150 : width ?? double.infinity,
        decoration: BoxDecoration(gradient: gradient),
        child: Material(
          color: Colors.transparent,
          child: Text(
            text,
            style: boldTextStyle(color: dkColorOnButton),
          ).center(),
        ),
      ),
    );
  }
}
