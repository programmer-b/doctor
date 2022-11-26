import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKHelpScreen extends StatefulWidget {
  const DKHelpScreen({super.key});

  @override
  State<DKHelpScreen> createState() => _DKHelpScreenState();
}

class _DKHelpScreenState extends State<DKHelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkHelpText)),
    );
  }
}
