import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/components/MLProfileFormComponent.dart';
import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/main.dart';

class MLUpdateProfileScreen extends StatefulWidget {
  @override
  _MLUpdateProfileScreenState createState() => _MLUpdateProfileScreenState();
}

class _MLUpdateProfileScreenState extends State<MLUpdateProfileScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
            ),
            height: double.infinity,
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  54.height,
                  Text('Update your information',
                      style: boldTextStyle(size: 24)),
                  32.height,
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
                  42.height,
                ],
              ),
            ),
          ),
          Positioned(
              top: 30,
              child: mlBackToPrevious(
                  context, appStore.isDarkModeOn ? white : blackColor)),

        ],
      ),
    );
  }
}
