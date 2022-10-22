import 'dart:developer';

import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:doctor/components/MLBottomNavigationBarWidget.dart';
import 'package:doctor/fragments/MLCalendarFragment.dart';
import 'package:doctor/fragments/MLChatFragment.dart';
import 'package:doctor/fragments/MLHomeFragment.dart';
import 'package:doctor/fragments/MLNotificationFragment.dart';
import 'package:doctor/fragments/MLProfileFragemnt.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class MLDashboardScreen extends StatefulWidget {
  static String tag = '/MLDashboardScreen';

  @override
  _MLDashboardScreenState createState() => _MLDashboardScreenState();
}

class _MLDashboardScreenState extends State<MLDashboardScreen> {
  int currentWidget = 0;
  List<Widget> widgets = [
    MLHomeFragment(),
    MLChatFragment(),
    MLCalendarFragment(),
    MLNotificationFragment(),
    MLProfileFragment(),
  ];

  @override
  void initState() {
    super.initState();

    init();
  }

  Future<void> init() async {
    // ;
  }

  // @override
  // void dispose() {
  //   ;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(mlPrimaryColor);
    final appState = Provider.of<AppState>(context);
    final token = appState.authCredentials?["data"]["token"] ?? "";
    log("JWT ${JwtDecoder.decode(token)}");
    return SafeArea(
      child: Scaffold(
        body: widgets[currentWidget],
        bottomNavigationBar:
            Container(color: Colors.white, child: showBottomDrawer()),
      ),
    );
  }

  Widget showBottomDrawer() {
    return MLBottomNavigationBarWidget(
      index: currentWidget,
      onTap: (index) {
        setState(() {});
        currentWidget = index;
      },
    );
  }
}
