import 'package:flutter/material.dart';
import 'package:doctor/main.dart';
import 'package:doctor/screens/PurchaseMoreScreen.dart';
import 'package:nb_utils/nb_utils.dart';

class MLDieaseaseComponent extends StatefulWidget {
  static String tag = '/MLDieaseaseComponent';

  @override
  MLDieaseaseComponentState createState() => MLDieaseaseComponentState();
}

class MLDieaseaseComponentState extends State<MLDieaseaseComponent> {
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
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radiusOnly(topRight: 32),
        backgroundColor: appStore.isDarkModeOn ? black : white,
      ),
      child: PurchaseMoreScreen().withHeight(context.height() * 0.7),
    );
  }
}
