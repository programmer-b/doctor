import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Fragments/apps/appointments/dk_history.dart';
import 'package:afyadaktari/Fragments/apps/appointments/dk_upcomingt.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKAppointmentScreen extends StatefulWidget {
  const DKAppointmentScreen({super.key});

  @override
  State<DKAppointmentScreen> createState() => _DKAppointmentScreenState();
}

class _DKAppointmentScreenState extends State<DKAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: dkPrimaryColor,
        title: const Text(dkMyAppointmentsText),
        bottom: TabBar(
          indicatorColor: white,
          tabs:  [
            Tab(text: dkUpcomingText.toUpperCase()),
            Tab(
              text: dkHistoryText.toUpperCase(),
            )
          ],
          controller: _controller,
        ),
      ),
      body:  TabBarView(
        controller: _controller,
          children: const [DKUpcomingAppointments(), DKAppointmentsHistory()]),
    );
  }
}
