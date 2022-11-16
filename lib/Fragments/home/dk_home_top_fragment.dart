import 'package:afyadaktari/Components/dk_home_apps.dart';
import 'package:afyadaktari/Components/dk_home_profile_head.dart';
import 'package:afyadaktari/Components/dk_home_top_actions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Commons/dk_colors.dart';
import '../../Components/dk_rounded_app_bar_component.dart';

class DKHomeTopFragment extends StatefulWidget {
  const DKHomeTopFragment({super.key});

  @override
  State<DKHomeTopFragment> createState() => _DKHomeTopFragmentState();
}

class _DKHomeTopFragmentState extends State<DKHomeTopFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: dkPrimaryColor,
        borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0)),
      ),
      child: SafeArea(
        child: RoundedAppBar(
          child: Column(
            children: [
              16.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [DKHomeProfileHead(), DKHomeTopActions()],
              ).paddingOnly(right: 16.0, left: 16.0),
              const DKHomeApps(),
            ],
          ),
        ),
      ),
    );
  }
}
