import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKTermsDescComponent extends StatelessWidget {
  const DKTermsDescComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Wrap(
        children: [
          Text(
            "By continuing, you agree to the $dkAppName ",
            style: primaryTextStyle(),
          ),
          InkWell(
              onTap: () => DKToast.toastTop("Conditions of use"),
              child: Text(
                "Conditions of use",
                style: primaryTextStyle(color: dkPrimaryColor),
              )),
          Text(
            " and ",
            style: primaryTextStyle(),
          ),
          InkWell(
              onTap: () => DKToast.toastTop("Privacy Notice"),
              child: Text(
                "Privacy Notice",
                style: primaryTextStyle(color: dkPrimaryColor),
              ))
        ],
      ),
    );
  }
}
