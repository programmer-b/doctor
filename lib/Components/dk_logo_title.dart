import 'package:afyadaktari/Commons/dk_assets.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKLogoTitle extends StatelessWidget {
  const DKLogoTitle(
      {super.key, this.width = double.infinity, this.imageWidth = 45});
  final double? width;
  final double imageWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            dkImageLogo,
            width: imageWidth,
            fit: BoxFit.cover,
          ),
          6.width,
          Text(
            dkAppName,
            style: boldTextStyle(size: 26),
          )
        ],
      ),
    );
  }
}
