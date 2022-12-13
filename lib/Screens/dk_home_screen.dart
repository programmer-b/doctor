import 'dart:developer';

import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_lists.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_home_app_button.dart';
import 'package:afyadaktari/Fragments/home/dk_home_drawer_fragment.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:afyadaktari/Screens/dk_appointment_screen.dart';
import 'package:afyadaktari/Screens/dk_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';


class DKHomeScreen extends StatefulWidget {
  const DKHomeScreen({super.key});

  @override
  State<DKHomeScreen> createState() => _DKHomeScreenState();
}

class _DKHomeScreenState extends State<DKHomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => context.read<DKProfileDataProvider>().setProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      drawer: const DKHomeDrawerFragment(),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.all(10),
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            alignment: WrapAlignment.spaceAround,
            children: List<Widget>.generate(
                homeApplications["apps"].length,
                (index) => DkHomeAppButton(
                    index: index,
                    image: homeApplications["apps"][index]["image"],
                    title: homeApplications["apps"][index]["name"])),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: const Text(dkAppName),
        backgroundColor: dkPrimaryColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Container(
            color: dkPrimaryColor,
            alignment: Alignment.center,
            child: Container(
                decoration: BoxDecoration(
                    color: cardLightColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.black12)),
                padding: const EdgeInsets.all(10),
                transform: Matrix4.translationValues(0, 16.0, 0),
                child: Text(
                  dkViewAllMyAppointments,
                  style: boldTextStyle(color: dkPrimaryColor),
                )),
          ).onTap(() => const DKAppointmentScreen().launch(context)),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                log("Log out");
                await context.showLogOut();
              },
              icon: const Icon(Icons.logout)),
          IconButton(
              onPressed: () => const DKProfileScreen().launch(context),
              icon: const Icon(
                Icons.account_circle,
                size: 30,
              ))
        ],
      );
}
