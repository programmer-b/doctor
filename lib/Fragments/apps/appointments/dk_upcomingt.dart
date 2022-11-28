import 'package:flutter/material.dart';

class DKUpcomingAppointments extends StatefulWidget {
  const DKUpcomingAppointments({super.key});

  @override
  State<DKUpcomingAppointments> createState() =>
      _DKUpcomingAppointmentsState();
}

class _DKUpcomingAppointmentsState
    extends State<DKUpcomingAppointments> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Upcoming appointments."),
    );
  }
}
