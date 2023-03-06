import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Fragments/apps/appointments/appointments_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Components/dk_button_component.dart';

class DKConfirmAppointment extends StatefulWidget {
  const DKConfirmAppointment({super.key, required this.controller});
  final PageController controller;

  @override
  State<DKConfirmAppointment> createState() => _DKConfirmAppointmentState();
}

class _DKConfirmAppointmentState extends State<DKConfirmAppointment> {
  late PageController controller = widget.controller;
  @override
  Widget build(BuildContext context) {
    final watcher = context.watch<AppointmentsProvider>();
    final Map<String, dynamic> _info = {
      dkTimeTxt: watcher.time,
      dkDateTxt: watcher.date,
      dkAmountTxt: "Ksh 1500",
      dkSpecialityTxt: "General practional",
      dkSpecialistTxt: "Dr kamau kaheze W."
    };
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.info,
              color: dkPrimaryColor,
              size: 100,
            ),
            12.height,
            Text(
              dkConfirmAppointMsg,
              textAlign: TextAlign.center,
              style: boldTextStyle(size: 19),
            ),
            24.height,
            for (int i = 0; i < _info.length; i++)
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: _info.keys.elementAt(i), style: boldTextStyle()),
                  TextSpan(text: "  :  ", style: boldTextStyle()),
                  TextSpan(
                      text: _info.values.elementAt(i), style: primaryTextStyle())
                ]),
              ).paddingSymmetric(vertical: 10),

               18.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DKButtonComponent(
              onTap: () => finish(context),
              text: 'Cancel',
              gradient: dkNavigateButtonGradient,
              height: 50,
              isMin: true,
            ),
            18.width,
            DKButtonComponent(
              onTap: () => controller.nextPage(
                      duration: 200.milliseconds, curve: Curves.easeOut),
              text: 'Continue',
              gradient: dkSubmitButtonGradient,
              height: 50,
              isMin: true,
            ),
          ],
        )
          ],
        ),
      ),
    );
  }
}
