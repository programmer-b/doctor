import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Components/dk_build_splash.dart';
import 'package:afyadaktari/Functions/auth_functions.dart';
import 'package:afyadaktari/Screens/dk_choose_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import 'dk_auth_screen.dart';
import 'dk_on_boarding_screen.dart';

class DKSplashScreen extends StatefulWidget {
  const DKSplashScreen({super.key});

  @override
  State<DKSplashScreen> createState() => _DKSplashScreenState();
}

class _DKSplashScreenState extends State<DKSplashScreen> {
  late Future<Map<String, dynamic>> ready;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    ready = _ready();
  }

  Future<Map<String, dynamic>> _ready() async {
    await refreshToken();

    final token = getStringAsync(keyToken);
    final onBoardingVisited = getBoolAsync(keyOnBoardingVisited);

    log("TOKEN: $token");

    await 3.seconds.delay;

    return {keyToken: token, keyOnBoardingVisited: onBoardingVisited};
  }

  Future<void> _goToRoleSelect() async {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => const DKChooseRole().launch(context, isNewTask: true));
  }

  Future<void> _goToAuth() async {
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => const DKAuthScreen().launch(context, isNewTask: true));
  }

  Future<void> _goToOnBoarding() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        const DKOnBoardingScreen().launch(context, isNewTask: true));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: ready,
        builder: (context, snapshot) {
          // if (snap.ready) {
          //   _goToRoleSelect();
          // }
          if (snapshot.ready) {
            final String token = snapshot.data?[keyToken];
            final bool onBoardingVisited = snapshot.data?[keyOnBoardingVisited];

            if (token.isNull) {
              onBoardingVisited ? _goToAuth() : _goToOnBoarding();
            } else {
              analyzeCredentials(token: token, context: context);
            }
          }
          return const DKBuildSplash();
        });
  }
}
