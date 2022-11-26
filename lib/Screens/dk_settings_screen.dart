import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKSettingsScreen extends StatefulWidget {
  const DKSettingsScreen({super.key});

  @override
  State<DKSettingsScreen> createState() => _DKSettingsScreenState();
}

class _DKSettingsScreenState extends State<DKSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(dkSettingsText),
      ),
    );
  }
}
