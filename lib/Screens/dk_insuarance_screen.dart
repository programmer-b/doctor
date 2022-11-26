import 'package:flutter/material.dart';

import '../Commons/dk_strings.dart';

class DKInsuaranceScreen extends StatefulWidget {
  const DKInsuaranceScreen({super.key});

  @override
  State<DKInsuaranceScreen> createState() => _DKInsuaranceScreenState();
}

class _DKInsuaranceScreenState extends State<DKInsuaranceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkMedicalInsuaranceText)),
    );
  }
}
