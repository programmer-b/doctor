import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKSubscription extends StatefulWidget {
  const DKSubscription({super.key});

  @override
  State<DKSubscription> createState() => _DKSubscriptionState();
}

class _DKSubscriptionState extends State<DKSubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkMedicalInsuaranceText)),
    );
  }
}
