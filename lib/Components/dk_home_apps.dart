import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Commons/dk_data_provider.dart';
import '../Models/dk_service_data_model.dart';
import '../Utils/dk_toast.dart';

class DKHomeApps extends StatelessWidget {
  const DKHomeApps({super.key});

  @override
  Widget build(BuildContext context) {
      List<MLServicesData> data = mlServiceDataList();

    return Container(
                margin: const EdgeInsets.only(right: 16.0, left: 16.0),
                transform: Matrix4.translationValues(0, 32.0, 0),
                alignment: Alignment.center,
                decoration: boxDecorationRoundedWithShadow(12,
                    backgroundColor: context.cardColor),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  direction: Axis.horizontal,
                  spacing: 8.0,
                  children: data.map(
                    (e) {
                      return Container(
                        constraints:
                            BoxConstraints(minWidth: context.width() * 0.25),
                        padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                        child: Column(
                          children: [
                            Image.asset(e.image!,
                                width: 28, height: 28, fit: BoxFit.fill),
                            8.height,
                            Text(e.title.toString(),
                                style: boldTextStyle(size: 12),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ).onTap(
                        () {
                          DKToast.toastTop(e.title.toString());
                        },
                      );
                    },
                  ).toList(),
                ),
              );
  }
}