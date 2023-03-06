import 'package:afyadaktari/Fragments/apps/appointments/confirm_appointment.dart';
import 'package:afyadaktari/Fragments/apps/appointments/schedule_date.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../Commons/dk_colors.dart';
import '../Commons/dk_strings.dart';
import '../Fragments/apps/appointments/book_results.dart';
import '../Fragments/apps/appointments/schedule_time.dart';

class DKBookAppointment extends StatefulWidget {
  const DKBookAppointment({super.key});

  @override
  State<DKBookAppointment> createState() => _DKBookAppointmentState();
}

class _DKBookAppointmentState extends State<DKBookAppointment> {
  final _controller = PageController();

  String _date = "";
  String get date => _date;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DKChooseScheduleDate(
        controller: _controller,
      ),
      DKChooseScheduleTime(
        controller: _controller,
      ),
      DKConfirmAppointment(
        controller: _controller,
      ),
      const DKBookResults()
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text(dkBookAppointment),
          backgroundColor: dkPrimaryColor,
          leading: BackButton(
              onPressed: () => _controller.page != 0
                  ? _controller.previousPage(
                      duration: 200.milliseconds, curve: Curves.easeOut)
                  : finish(context)),
        ),
        body: PageView(
          controller: _controller,
          allowImplicitScrolling: true,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ));
  }
}
