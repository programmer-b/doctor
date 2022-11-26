import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKOrderScreen extends StatefulWidget {
  const DKOrderScreen({super.key});

  @override
  State<DKOrderScreen> createState() => _DKOrderScreenState();
}

class _DKOrderScreenState extends State<DKOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkOrderText)),
    );
  }
}
