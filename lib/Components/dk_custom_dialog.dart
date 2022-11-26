import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKCustomDialog extends StatelessWidget {
  const DKCustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.positiveText,
      required this.onTap});
  final String title;
  final String content;
  final String positiveText;
  final dynamic Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
        padding: const EdgeInsets.all(25),
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: boldTextStyle(color: Colors.black),
                textAlign: TextAlign.start,
              ),
              12.height,
              Text(content, style: primaryTextStyle(color: Colors.black54)),
              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DKButtonComponent(
                    onTap: () => finish(context),
                    text: "CANCEL",
                    isMin: true,
                    gradient: dkNavigateButtonGradient,
                  ),
                  12.width,
                  DKButtonComponent(
                    onTap: onTap,
                    text: positiveText.toUpperCase(),
                    isMin: true,
                    gradient: dkSubmitButtonGradient,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
