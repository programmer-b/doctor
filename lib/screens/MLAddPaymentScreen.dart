import 'package:flutter/material.dart';
import 'package:doctor/components/MLBookedDailog.dart';
import 'package:doctor/main.dart';
import 'package:doctor/screens/PurchaseMoreScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:nb_utils/nb_utils.dart';

class MLAddPaymentScreen extends StatefulWidget {
  static String tag = '/MLAddPaymentScreen';

  @override
  MLAddPaymentScreenState createState() => MLAddPaymentScreenState();
}

class MLAddPaymentScreenState extends State<MLAddPaymentScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            PurchaseMoreScreen().withHeight(context.height() * 0.6),
            Positioned(
              top: 32.0,
              left: 24.0,
              child: mlBackToPreviousWidget(
                  context, appStore.isDarkModeOn ? white : black),
            ),
            Positioned(
              bottom: 8,
              right: 16.0,
              left: 16.0,
              child: Column(
                children: [
                  8.height,
                  AppButton(
                    width: context.width(),
                    color: mlColorDarkBlue,
                    child: Text("Save", style: boldTextStyle(color: white)),
                    onTap: () {
                      _showDialog(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return MLBookedDialog();
      },
    );
  }
}
