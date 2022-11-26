import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKInvoiceScreen extends StatefulWidget {
  const DKInvoiceScreen({super.key});

  @override
  State<DKInvoiceScreen> createState() => _DKInvoiceScreenState();
}

class _DKInvoiceScreenState extends State<DKInvoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(dkInvoiceText)),
    );
  }
}
