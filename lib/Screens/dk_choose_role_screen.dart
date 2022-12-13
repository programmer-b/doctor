import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Commons/enums.dart';
import 'package:afyadaktari/Provider/dk_role_provider.dart';
import 'package:afyadaktari/Screens/dk_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Components/dk_logo_title.dart';

class DKChooseRole extends StatefulWidget {
  const DKChooseRole({super.key});

  @override
  State<DKChooseRole> createState() => _DKChooseRoleState();
}

class _DKChooseRoleState extends State<DKChooseRole> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<DKRoleProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: dkScaffoldColor,
        elevation: 0.0,
        centerTitle: true,
        title: const DKLogoTitle(),
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  provider.setRole(Roles.admin);
                  const DKAuthScreen().launch(context);
                },
                child: Text(
                  dkAdminText,
                  style: boldTextStyle(color: white),
                )).withSize(height: 45, width: 150),
            16.height,
            ElevatedButton(
                onPressed: () {
                  provider.setRole(Roles.doctor);
                  const DKAuthScreen().launch(context);
                },
                child: Text(
                  dkDoctorText,
                  style: boldTextStyle(color: white),
                )).withSize(height: 45, width: 150),
            16.height,
            ElevatedButton(
                onPressed: () {
                  provider.setRole(Roles.patient);
                  const DKAuthScreen().launch(context);
                },
                child: Text(
                  dkPatientText,
                  style: boldTextStyle(color: white),
                )).withSize(height: 45, width: 150)
          ],
        ).center(),
      ),
    );
  }
}
