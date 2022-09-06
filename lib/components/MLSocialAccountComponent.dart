import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:doctor/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLImage.dart';

class MLSocialAccountsComponent extends StatefulWidget {
  static String tag = '/MLSocialAccountsComponent';

  @override
  MLSocialAccountsComponentState createState() =>
      MLSocialAccountsComponentState();
}

class MLSocialAccountsComponentState extends State<MLSocialAccountsComponent> {
  List<String?> data = <String?>[
    ml_ic_logo_google,
    ml_ic_logo_fb,
    ml_ic_logo_ios
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: data.map(
        (e) {
          return Container(
            margin: EdgeInsets.only(right: 8, left: 8),
            padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radius(12),
              backgroundColor: appStore.isDarkModeOn ? cardDarkColor : white,
              border: Border.all(color: mlColorLightGrey),
            ),
            child: Image.asset(e.validate(), height: 24, width: 24),
          ).expand();
        },
      ).toList(),
    );
  }
}
