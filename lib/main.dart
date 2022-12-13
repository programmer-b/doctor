import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:afyadaktari/Provider/dk_login_data_provider.dart';
import 'package:afyadaktari/Provider/dk_mobile_provider.dart';
import 'package:afyadaktari/Provider/dk_otp_data_provider.dart';
import 'package:afyadaktari/Provider/dk_password_data_provider.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:afyadaktari/Provider/dk_register_data_provider.dart';
import 'package:afyadaktari/Provider/dk_role_provider.dart';
import 'package:afyadaktari/Provider/dk_screen_ui_provider.dart';
import 'package:afyadaktari/Screens/dk_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'Provider/dk_navigation_drawer_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setStatusBarColor(Colors.transparent);
  setOrientationPortrait();

  await initialize().then(
    (value) => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ScreenUiProvider()),
          ChangeNotifierProvider(create: (context) => DkAuthUiState()),
          ChangeNotifierProvider(create: (context) => DKLoginDataProvider()),
          ChangeNotifierProvider(create: (context) => DKRegisterDataProvider()),
          ChangeNotifierProvider(create: (context) => DKOTPDataProvider()),
          ChangeNotifierProvider(
            create: (context) => DKPasswordProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DKProfileDataProvider(),
          ),
          ChangeNotifierProvider(create: (context) => DKMobileProvider()),
          ChangeNotifierProvider(create: (context) => DKNavigationDrawerProvider()),
          ChangeNotifierProvider(create: (context) => DKRoleProvider())
        ],
        child: MaterialApp(
          title: dkAppName,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey.shade200,
              textTheme: const TextTheme(
                  headline6: TextStyle(color: dkPrimaryTextColor))),
          home: const DKSplashScreen(),
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
