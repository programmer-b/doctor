import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
// import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/components/MLProfileFormComponent.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/main.dart';
import 'package:provider/provider.dart';

import '../services/networking.dart';
import '../state/appstate.dart';

class MLUpdateProfileScreen extends StatefulWidget {
  @override
  _MLUpdateProfileScreenState createState() => _MLUpdateProfileScreenState();
}

class _MLUpdateProfileScreenState extends State<MLUpdateProfileScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    changeStatusColor(appStore.isDarkModeOn ? scaffoldDarkColor : white);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    provider.isLoading ? Loader.show(context) : Loader.hide();
    return Scaffold(
      appBar: AppBar(
        title: Text('Update your information',
            style: boldTextStyle(size: 24, color: appStore.appBarTextColor)),
        backgroundColor: appStore.appBarColor,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness:
                appStore.isDarkModeOn ? Brightness.light : Brightness.dark),
      ),
      backgroundColor: appStore.scaffoldBackground,
      body: Container(
        margin: EdgeInsets.only(top: 24.0),
        height: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              16.height,
              MLProfileFormComponent(),
            ],
          ),
        ),
      ),
    );
  }
}
