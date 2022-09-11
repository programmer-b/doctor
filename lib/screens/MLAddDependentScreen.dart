import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/components/MLProfileFormComponent.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/main.dart';

class MLAddDependentScreen extends StatefulWidget {
  static String tag = '/MLAddDependentScreen';

  @override
  MLAddDependentScreenState createState() => MLAddDependentScreenState();
}

class MLAddDependentScreenState extends State<MLAddDependentScreen> {
  late String firstNameCache = '';
  late String middleNameCache = '';
  late String lastNameCache = '';
  late String dateOfBirthCache = '';
  late String bloodGroupCache = '';
  late String phoneNumberCache = '';
  late String residenceCache = '';
  late String genderCache = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    firstNameCache = await getStringAsync("firstName");
    middleNameCache = await getStringAsync("middleName");
    lastNameCache = await getStringAsync("lastName");
    dateOfBirthCache = await getStringAsync("dateOfBirth");
    bloodGroupCache = await getStringAsync("bloodGroup");
    phoneNumberCache = await getStringAsync("phoneNumber");
    residenceCache = await getStringAsync("residence");
    genderCache = await getStringAsync("gender");
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              height: context.height(),
              padding: EdgeInsets.all(16.0),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    mlBackToPreviousWidget(
                        context, appStore.isDarkModeOn ? white : black),
                    34.height,
                    Text('Add A Dependent', style: boldTextStyle(size: 24)),
                    16.height,
                    MLProfileFormComponent(
                      bloodGroupCache: bloodGroupCache,
                      dateOfBirthCache: dateOfBirthCache,
                      firstNameCache: firstNameCache,
                      middleNameCache: middleNameCache,
                      phoneNumberCache: phoneNumberCache,
                      residenceCache: residenceCache,
                      lastNameCache: lastNameCache,
                      genderCache: genderCache,
                    ),
                    48.height,
                  ],
                ),
              ),
            ),
            AppButton(
              width: context.width(),
              color: mlColorDarkBlue,
              child: Text("Save", style: boldTextStyle(color: white)),
              onTap: () {
                finish(context);
              },
            ).paddingOnly(right: 16, left: 16, bottom: 16),
          ],
        ),
      ),
    );
  }
}
