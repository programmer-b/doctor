import 'package:flutter/material.dart';

class DKAppointmentsHistory extends StatefulWidget {
  const DKAppointmentsHistory({super.key});

  @override
  State<DKAppointmentsHistory> createState() => _DKAppointmentsHistoryState();
}

class _DKAppointmentsHistoryState extends State<DKAppointmentsHistory> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("You have no previous appointments"),
    );
  }
}
