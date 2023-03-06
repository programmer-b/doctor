import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Commons/dk_colors.dart';
import '../../../Components/dk_button_component.dart';
import 'appointments_provider.dart';

class DKChooseScheduleTime extends StatefulWidget {
  const DKChooseScheduleTime({super.key, required this.controller});
  final PageController controller;

  @override
  State<DKChooseScheduleTime> createState() => _DKChooseScheduleTimeState();
}

class _DKChooseScheduleTimeState extends State<DKChooseScheduleTime> {
  late PageController controller = widget.controller;
  int _selectedSlot = -1;
  int get selectedSlot => _selectedSlot;
  @override
  Widget build(BuildContext context) {
    final watcher = context.watch<AppointmentsProvider>();
    final reader = context.read<AppointmentsProvider>();
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        Text(
          'Choose your appointment time on ${watcher.date}',
          style: boldTextStyle(),
        ).center(),
        16.height,
        Container(
          alignment: Alignment.center,
          child: Wrap(
            spacing: 18,
            runSpacing: 18,
            // alignment: WrapAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 20; i++)
                Builder(builder: (context) {
                  double time = (i + 14) / 2;
                  String timeString = time.floor().toString();
                  String timeStringNext = (time.floor() + 1).toString();
                  String timeSlot = i % 2 == 0
                      ? '$timeString:00-$timeString:30'
                      : '$timeString:30-$timeStringNext:00';
                  return InkWell(
                    onTap: () => setState(() {
                      selectedSlot == i
                          ? _selectedSlot = -1
                          : _selectedSlot = i;
                      reader.setTime(timeSlot);
                    }),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: context.width() * 0.4, minHeight: 50),
                      decoration: BoxDecoration(
                          color: i == selectedSlot ? dkPrimaryColor : null,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: dkPrimaryColor)),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        timeSlot,
                        style: primaryTextStyle(
                            color: i == selectedSlot
                                ? Colors.white
                                : Colors.black),
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
        18.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DKButtonComponent(
              onTap: () => controller.previousPage(
                  duration: 200.milliseconds, curve: Curves.easeOut),
              text: 'Back',
              gradient: dkNavigateButtonGradient,
              height: 50,
              isMin: true,
            ),
            18.width,
            DKButtonComponent(
              onTap: () => _selectedSlot == -1
                  ? toast("Please select your appointment time.")
                  : controller.nextPage(
                      duration: 200.milliseconds, curve: Curves.easeOut),
              text: 'Continue',
              gradient: dkSubmitButtonGradient,
              height: 50,
              isMin: true,
            ),
          ],
        )
      ],
    );
  }
}
