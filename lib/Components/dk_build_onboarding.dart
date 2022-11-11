import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKBuildOnBoarding extends StatelessWidget {
  const DKBuildOnBoarding(
      {super.key,
      required this.color,
      required this.urlImage,
      required this.title,
      required this.subtitle});
  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              height: context.height() * 0.5,
              fit: BoxFit.fill,
            ),
            64.height,
            Text(
              title,
              style: boldTextStyle(size: 26, color: dkPrimaryColor),
            ),
            24.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                subtitle,
                style: primaryTextStyle(),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
}
