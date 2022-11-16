import 'package:afyadaktari/Fragments/home/dk_home_top_fragment.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:flutter/material.dart';
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
      body: SingleChildScrollView(
          child: Column(children: const [DKHomeTopFragment()])),
    );
  }
}
