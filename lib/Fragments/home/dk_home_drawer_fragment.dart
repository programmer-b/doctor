import 'package:afyadaktari/Commons/dk_lists.dart';
import 'package:afyadaktari/Components/dk_drawer_app_tile.dart';
import 'package:afyadaktari/Components/dk_drawer_header.dart';
import 'package:flutter/material.dart';

class DKHomeDrawerFragment extends StatefulWidget {
  const DKHomeDrawerFragment({super.key});

  @override
  State<DKHomeDrawerFragment> createState() => _DKHomeDrawerFragmentState();
}

class _DKHomeDrawerFragmentState extends State<DKHomeDrawerFragment> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DkDrawerHeader(),
          Column(
            children: List<Widget>.generate(
                drawerApplications["apps"].length,
                (index) => DKDrawerAppTile(
                    index: index, app: drawerApplications["apps"][index])),
          )
        ],
      ),
    );
  }
}
