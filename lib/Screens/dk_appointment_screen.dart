import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:flutter/material.dart';

class DKAppointmentScreen extends StatefulWidget {
  const DKAppointmentScreen({super.key});

  @override
  State<DKAppointmentScreen> createState() => _DKAppointmentScreenState();
}

class _DKAppointmentScreenState extends State<DKAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(dkMyAppointmentsText),
      ),
    );
  }
}
