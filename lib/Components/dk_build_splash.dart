import 'package:afyadaktari/Commons/dk_assets.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKBuildSplash extends StatelessWidget {
  const DKBuildSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: Image.asset(dkImageLogo, width: context.width() * 0.40)),
          10.height,
          Text(
            dkAppName,
            style: boldTextStyle(size: 21),
          )
        ],
      ),
    ));
  }
}
