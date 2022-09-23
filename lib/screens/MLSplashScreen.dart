import 'dart:convert';
import 'dart:developer';

import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/state/appstate.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:flutter/material.dart';
import 'package:doctor/screens/MLWalkThroughScreen.dart';
import 'package:doctor/utils/MLImage.dart';
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

  bool isLoading = false;

  Future<Map<String, dynamic>?> getAuthCredentials() async {
    return await getJSONAsync('auth');
  }

  Future<Map<String, dynamic>?> getProfileInfo() async {
    return await getJSONAsync('profile');
  }

  Future<Map<String, dynamic>?> getProfileFromDatabase(
      {required Uri uri, required String token}) async {
    setState(() => isLoading = true);
    try {
      final data = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      setState(() => isLoading = true);
      return jsonDecode(data.body);
    } catch (e) {
      setState(() => isLoading = false);
      return null;
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
      required Map<String, dynamic>? credentials}) async {
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
    MLDashboardScreen().launch(context,
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
                                uri: Uri.parse(getProfile +
                                    '${credentials.data?['data']['user_id'] ?? ''}'),
                                token:
                                    '${credentials.data?['data']['token'] ?? ''}'),
                            builder: (context,
                                AsyncSnapshot<Map<String, dynamic>?>
                                    profileFromDb) {
                              if (profileFromDb.connectionState ==
                                  ConnectionState.done) {
                                log('PROFILE DATA: ${profileFromDb.data}');
                                if (profileFromDb.data?.isNotEmpty ?? false) {
                                  launchToDashboard(
                                      profile: profileFromDb.data,
                                      credentials: credentials.data);
                                } else {
                                  launchToProfile(
                                      credentials: credentials.data);
                                }
                              }
                              else if (profileFromDb.hasError) {
                                toast(
                                    'Something went wrong ${profileFromDb.error}');
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
