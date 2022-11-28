import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/dk_colors.dart';
import '../Provider/dk_navigation_drawer_provider.dart';

class DKDrawerAppTile extends StatelessWidget {
  const DKDrawerAppTile(
      {super.key, required this.index, required this.app, this.onTap});
  final int index;
  final Map<String, dynamic> app;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Consumer<DKNavigationDrawerProvider>(
        builder: (context, snapshot, widget) {
      bool isCurrentIndex = snapshot.currentIndex == index;
      final Widget? route = app["route"];
      return InkWell(
        onTap: app["name"] == dkLogOut
            ? () => context.showLogOut()
            : () => route.launch(context,
                pageRouteAnimation: PageRouteAnimation.Slide),
        child: Container(
          color: isCurrentIndex ? Colors.black12 : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                app["icon"],
                color: isCurrentIndex ? dkPrimaryColor : Colors.black,
              ),
              10.width,
              Text(app["name"],
                  style: boldTextStyle(
                      color: isCurrentIndex ? dkPrimaryColor : Colors.black))
            ],
          ),
        ),
      );
    });
  }
}
