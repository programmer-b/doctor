import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Screens/dk_profile_screen.dart';

class DkDrawerHeader extends StatelessWidget {
  const DkDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<DKProfileDataProvider>();
    return DrawerHeader(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(color: dkPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_circle,
              color: Colors.white38,
              size: 70,
            ).onTap(() => const DKProfileScreen().launch(context)),
            8.height,
            Text(
              "${profile.firstName}  ${profile.lastName}",
              style: boldTextStyle(color: Colors.white),
            ),
            4.height,
            Text(
              getStringAsync(keyMobile),
              style: primaryTextStyle(color: Colors.white54),
            )
          ],
        ).center());
  }
}
