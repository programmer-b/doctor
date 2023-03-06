import 'dart:developer';

import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'appointments_provider.dart';

class DKChooseScheduleDate extends StatefulWidget {
  const DKChooseScheduleDate({super.key, required this.controller});
  final PageController controller;

  @override
  State<DKChooseScheduleDate> createState() => _DKChooseScheduleDateState();
}

class _DKChooseScheduleDateState extends State<DKChooseScheduleDate> {
  late PageController controller = widget.controller;
  final _dateController = DateRangePickerController();

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reader = context.read<AppointmentsProvider>();
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Choose your appointment date',
          style: boldTextStyle(),
        ).center(),
        16.height,
        SfDateRangePicker(
          onSelectionChanged: (args) {
            reader.setDate(
                args.value.toString().substring(0, 10).replaceAll('-', '/'));
          },
          controller: _dateController,
        ).withSize(
            width: context.width() * 0.8, height: context.height() * 0.5),
        12.height,
        DKButtonComponent(
          onTap: () => _dateController.selectedDate == null
              ? toast('Please select a date to proceed')
              : controller.nextPage(
                  duration: 200.milliseconds, curve: Curves.easeOut),
          text: 'Continue',
          gradient: dkSubmitButtonGradient,
          height: 50,
        )
      ],
    );
  }
}
