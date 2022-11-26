import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKSubscriptionScreen extends StatefulWidget {
  const DKSubscriptionScreen({super.key});

  @override
  State<DKSubscriptionScreen> createState() => _DKSubscriptionScreenState();
}

class _DKSubscriptionScreenState extends State<DKSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkSubscriptionText)),
    );
  }
}
