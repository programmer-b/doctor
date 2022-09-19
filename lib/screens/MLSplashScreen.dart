import 'dart:convert';
import 'dart:developer';

import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/state/appstate.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/MLWalkThroughScreen.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MLSplashScreen extends StatefulWidget {
  @override
  _MLSplashScreenState createState() => _MLSplashScreenState();
}

class _MLSplashScreenState extends State<MLSplashScreen> {
  @override
  void initState() {
    super.initState();
    //
    init();
  }

  Future<void> init() async {
    // await 2.seconds.delay;
    // finish(context);
    // MLWalkThroughScreen().launch(context);
  }

  Future<Map<String, dynamic>?> getAuthCredentials() async {
    return await getJSONAsync('auth');
  }

  Future<Map<String, dynamic>?> getProfileInfo() async {
    return await getJSONAsync('profile');
  }

  Future<void> launchToLogin() async {
    await 3.seconds.delay;
    MLWalkThroughScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  Future<void> initializeProfile() async {}

  void launchDashBoard(context) {
    MLDashboardScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
            future: getAuthCredentials(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data?.isNotEmpty ?? false) {
                  initializeUser(snapshot.data, appState, context);
                } else {
                  launchToLogin();
                }
              }
              return Image.asset(ml_ic_medilab_logo,
                      height: 150, width: 150, fit: BoxFit.fill)
                  .center();
            }));
  }

  Future<void> initializeUser(
      Object? data, AppState provider, BuildContext context) async {
    log('Data: $data');

    provider.initializeAuthInfo(data);
    final profile = await getProfileInfo();

    if (profile?.isNotEmpty ?? false) {
      provider.initializeProfileInfo(profile);
      await 2.seconds.delay;
      launchDashBoard(context);
    } else {
      try {
        final data = await http.get(Uri.parse(getProfile));
        // ignore: todo
        //TODO: we need to get profile data from database
        if (data.OK) {
          provider.initializeProfileInfo(jsonDecode(data.body));
          await 2.seconds.delay;
          launchDashBoard(context);
        } else {
          // ignore: todo
          //TODO: check if there is a database error
          await 2.seconds.delay;
          MLUpdateProfileScreen()
              .launch(context, pageRouteAnimation: PageRouteAnimation.Scale);
        }
      } catch (e) {
        toast('Check your connection and try again',
            bgColor: mlPrimaryColor,
            textColor: Colors.white,
            length: Toast.LENGTH_LONG);
      }
    }
  }
}
