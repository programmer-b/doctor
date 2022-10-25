import 'dart:developer';

import 'package:doctor/model/MLJWTDecoder.dart';
import 'package:doctor/screens/MLAuthenticationScreen.dart';
import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/MLWalkThroughScreen.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

// import '../services/networking.dart';

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

  bool isLoading = true;

  Future<Map<String, dynamic>?> getAuthCredentials() async {
    return await getJSONAsync('auth');
  }

  Future<Map<String, dynamic>?> getProfileCredentials() async {
    return await getJSONAsync('profile');
  }

  Future<dynamic> launchToLogin() async {
    await 2.seconds.delay;
    return MLWalkThroughScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  Future<dynamic> launchToDashboard(
      {MLJWTDecoder? decodedToken,
      Map<String, dynamic>? profile,
      required Map<String, dynamic>? credentials}) async {
    assert(profile != null || decodedToken != null);
    await 2.seconds.delay;
    context.read<AppState>().initializeAuthInfo(credentials);
    profile != null
        ? context.read<AppState>().initializeProfileInfo(profile: profile)
        : context.read<AppState>().initializeProfileInfo(data: decodedToken);
    MLDashboardScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  Future<dynamic> launchToProfile(
      {required Map<String, dynamic>? credentials}) async {
    await 2.seconds.delay;
    context.read<AppState>().initializeAuthInfo(credentials);
    MLUpdateProfileScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  Future<void> launchToAuthentication(
      {required Map<String, dynamic>? credentials}) async {
    await 2.seconds.delay;
    context.read<AppState>().initializeAuthInfo(credentials);
    MLAuthenticationScreen(resend: true).launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<Networking>(context);
    return FutureBuilder<Map<String, dynamic>?>(
        future: getAuthCredentials(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> credentials) {
          if (credentials.connectionState == ConnectionState.done) {
            if (credentials.data?.isNotEmpty ?? false) {
              return FutureBuilder<Map<String, dynamic>?>(
                  future: getProfileCredentials(),
                  builder: (context, AsyncSnapshot profileSnap) {
                    if (profileSnap.connectionState == ConnectionState.done) {
                      if (profileSnap.data?.isNotEmpty ?? false) {
                        log("PROFILE IN CACHE: ${profileSnap.data}");
                        launchToDashboard(
                            profile: profileSnap.data,
                            credentials: credentials.data);
                      } else {
                        final token = credentials.data?['data']?['token'] ?? '';

                        final decodedToken = JwtDecoder.decode(token) ?? {};

                        log("DECODED TOKEN: $decodedToken");

                        if (decodedToken["usr"]["mobile_verified"] == null) {
                          launchToAuthentication(credentials: credentials.data);
                        } else if (decodedToken["usr"]["profile_verified"] ==
                            null) {
                          launchToProfile(credentials: credentials.data);
                        } else {
                          log("Launching to dashboard...");

                          final decodedTokenModel = MLJWTDecoder.fromJson(
                              JwtDecoder.decode(token) ?? {});

                          launchToDashboard(
                              credentials: credentials.data,
                              decodedToken: decodedTokenModel);
                        }
                      }
                    }
                    return buildSplash();
                  });
            } else {
              launchToLogin();
            }
          }
          return buildSplash();
        });
  }

  Widget buildSplash() {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ml_ic_medilab_logo,
              height: 150, width: 150, fit: BoxFit.fill),
          24.height,
          Loader().visible(isLoading)
        ],
      ).center(),
    );
  }
}
