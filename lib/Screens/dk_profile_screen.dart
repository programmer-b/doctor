import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/enums.dart';
import 'package:afyadaktari/Fragments/auth/dk_password_fragment.dart';
import 'package:afyadaktari/Fragments/auth/dk_profile_fragment.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:afyadaktari/Screens/dk_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DKProfileScreen extends StatefulWidget {
  const DKProfileScreen({super.key});

  @override
  State<DKProfileScreen> createState() => _DKProfileScreenState();
}

class _DKProfileScreenState extends State<DKProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: dkPrimaryColor,
          title: Text(
            "Profile",
            style: boldTextStyle(color: white),
          ),
          actions: [
            PopupMenuButton<ProfileMenu>(
              onSelected: (ProfileMenu item) {
                switch (item) {
                  case ProfileMenu.edit:
                    const DKAuthScreen(
                      initFragment: DKProfileFragment(
                        isUpdateProfile: true,
                      ),
                    ).launch(context);
                    break;
                  case ProfileMenu.changePassword:
                    const DKAuthScreen(
                      initFragment:
                          DKPasswordFragment(type: keyTypeChangePassword),
                    ).launch(context);
                    break;
                  case ProfileMenu.logout:
                    context.showLogOut();

                    break;
                }
              },
              itemBuilder: (context) {
                return <PopupMenuEntry<ProfileMenu>>[
                  const PopupMenuItem(
                    value: ProfileMenu.edit,
                    child: Text("Edit profile"),
                  ),
                  const PopupMenuItem(
                    value: ProfileMenu.changePassword,
                    child: Text("Change password"),
                  ),
                  const PopupMenuItem(
                    value: ProfileMenu.logout,
                    child: Text("Logout"),
                  )
                ];
              },
            )
          ],
        ),
        body: Consumer<DKProfileDataProvider>(builder: (context, value, child) {
          final profile = value.profile.usr?.profile;
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            children: [
              _tile(
                title: 'First name',
                subtitle: profile?.firstName ?? "",
              ),
              _tile(title: 'Middle name', subtitle: profile?.middleName ?? ""),
              _tile(title: 'Last name', subtitle: profile?.lastName ?? ""),
              _tile(title: 'Email', subtitle: profile?.email ?? ""),
              _tile(
                  title: 'County of residence',
                  subtitle: profile?.countyOfResidence ?? ""),
              _tile(title: 'Sub county', subtitle: profile?.subCounty ?? ""),
              _tile(title: 'Gender', subtitle: profile?.gender ?? ""),
              _tile(title: 'Blood group', subtitle: profile?.bloodGroup ?? ""),
              _tile(
                  title: 'Date of birth', subtitle: profile?.dateOfBirth ?? ""),
            ],
          );
        }));
  }

  Widget _tile({required String title, required String subtitle}) =>
      subtitle == ""
          ? Container()
          : Column(
              children: [
                ListTile(
                  dense: true,
                  tileColor: Colors.blue.shade100,
                  title: Text(
                    title,
                    style: primaryTextStyle(size: 13),
                  ),
                  subtitle: Text(
                    subtitle,
                    style: primaryTextStyle(size: 16, color: Colors.black),
                  ),
                ),
                10.height
              ],
            );
}
