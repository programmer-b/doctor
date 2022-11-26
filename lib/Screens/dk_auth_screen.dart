import 'package:afyadaktari/Components/dk_logo_title.dart';
import 'package:afyadaktari/Provider/dk_auth_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DKAuthScreen extends StatefulWidget {
  const DKAuthScreen({super.key, this.initFragment});
  final Widget? initFragment;

  @override
  State<DKAuthScreen> createState() => _DKAuthScreenState();
}

class _DKAuthScreenState extends State<DKAuthScreen> {
  Widget? get initFragment => widget.initFragment;
  @override
  Widget build(BuildContext context) {
    final currentFragment =
        initFragment ?? context.watch<DkAuthUiState>().currentFragment;
    return SafeArea(
      child: Scaffold(
          body: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [const DKLogoTitle(), 25.height, currentFragment],
          ),
        ),
      )),
    );
  }
}
