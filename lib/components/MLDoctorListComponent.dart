import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:doctor/model/MLDoctorData.dart';
import 'package:doctor/screens/PurchaseMoreScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLDataProvider.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MLScheduleAppointmentComponent.dart';

class MLDoctorListComponent extends StatefulWidget {
  static String tag = '/MLDoctorListComponent';

  @override
  MLDoctorListComponentState createState() => MLDoctorListComponentState();
}

class MLDoctorListComponentState extends State<MLDoctorListComponent> {
  List<MLDoctorData> doctorDataList = mlDoctorListDataList();
  List<String?> time = mlScheduleTimeList();
  int? selectedIndex = 0;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Doctors', style: boldTextStyle(size: 24)),
                    8.height,
                    Text('Find the service you are',
                        style: secondaryTextStyle()),
                    16.height,
                  ],
                ).expand(),
                mlRoundedIconContainer(Icons.search, mlColorBlue),
                16.width,
                mlRoundedIconContainer(
                    Icons.calendar_view_day_outlined, mlColorBlue),
              ],
            ),
            8.height,
            PurchaseMoreScreen().withHeight(context.height() * 0.6),
          ],
        ).paddingAll(16.0),
        Container(
          color: context.cardColor,
          child: Text(
            'Schedule appointment time',
            style: boldTextStyle(
                color: mlColorDarkBlue, decoration: TextDecoration.underline),
          ),
        ).paddingOnly(right: 16, bottom: 72).onTap(
          () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (builder) {
                return MLScheduleApoointmentSheet();
              },
            );
          },
        ),
      ],
    );
  }
}
