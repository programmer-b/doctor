import 'dart:convert';
import 'dart:developer';

import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLUpdateProfileScreen.dart';
import 'package:doctor/state/appstate.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/MLWalkThroughScreen.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, dynamic>?> getProfileInfo() async {
    return await getJSONAsync('profile');
  }

  Future<Response> getProfileFromDatabase(
      {required Uri uri, required String token}) async {
    log("$uri");
    try {
      final data = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      return data;
    } catch (e) {
      throw (e);
    }
  }

  Future<dynamic> launchToLogin() async {
    await 2.seconds.delay;
    return MLWalkThroughScreen().launch(context,
        pageRouteAnimation: PageRouteAnimation.Scale, isNewTask: true);
  }

  Future<void> initializeProfile() async {}

  Future<dynamic> launchToDashboard(
      {required Map<String, dynamic>? profile,
      required Map<String, dynamic>? credentials,
      bool firstTime = false}) async {
    if (firstTime) {
      log("setting profile to shared_preferences");
      await setValue("profile", profile);
    }
    await 2.seconds.delay;
    context.read<AppState>().initializeAuthInfo(credentials);
    context.read<AppState>().initializeProfileInfo(profile);
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

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<Networking>(context);
    return FutureBuilder<Map<String, dynamic>?>(
        future: getAuthCredentials(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> credentials) {
          if (credentials.connectionState == ConnectionState.done) {
            if (credentials.data?.isNotEmpty ?? false) {
              log("$credentials");
              return FutureBuilder<Map<String, dynamic>?>(
                  future: getProfileInfo(),
                  builder:
                      (context, AsyncSnapshot<Map<String, dynamic>?> profile) {
                    if (profile.connectionState == ConnectionState.done) {
                      if (profile.data?.isNotEmpty ?? false) {
                        launchToDashboard(
                            credentials: credentials.data,
                            profile: profile.data);
                      } else {
                        log('Profile data not found in the cache: Checking for profile in the database ...');
                        return FutureBuilder(
                            future: getProfileFromDatabase(
                                uri: Uri.parse(getProfile),
                                token:
                                    '${credentials.data?['data']['token'] ?? ''}'),
                            builder: (context,
                                AsyncSnapshot<Response> profileFromDb) {
                              if (profileFromDb.connectionState ==
                                  ConnectionState.done) {
                                log('PROFILE DATA: ${profileFromDb.data!.body}');
                                int statusCode = jsonDecode(
                                    profileFromDb.data!.body)['statusCode'];
                                log('StatusCode: $statusCode \n HAS DATA: ${statusCode == 200}');
                                if (statusCode == 200) {
                                  launchToDashboard(
                                      firstTime: true,
                                      profile:
                                          jsonDecode(profileFromDb.data!.body),
                                      credentials: credentials.data);
                                } else if (statusCode == 401) {
                                  toast(
                                      'Your session has expired, Please Login again',
                                      length: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                      bgColor: Colors.red);
                                  launchToLogin();
                                } else if (statusCode == 404) {
                                  launchToProfile(
                                      credentials: credentials.data);
                                }
                              } else {
                                toast(
                                    'Something went wrong ${profileFromDb.error}',
                                    length: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    bgColor: Colors.red);
                              }
                              return buildSplash();
                            });
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
