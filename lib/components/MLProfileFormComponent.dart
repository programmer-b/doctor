import 'package:doctor/screens/MLDashboardScreen.dart';
import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:doctor/state/appstate.dart';
import 'package:doctor/utils/MLJSON.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' hide Loader;
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../services/networking.dart';

class MLProfileFormComponent extends StatefulWidget {
  MLProfileFormComponent(
      {Key? key,
     })
      : super(key: key);
  static String tag = '/MLProfileFormComponent';



  @override
  MLProfileFormComponentState createState() => MLProfileFormComponentState();
}

class MLProfileFormComponentState extends State<MLProfileFormComponent> {
  String? extractError(Networking provider, String name) {
    try {
      final error = provider.failureMap["errors"][name][0];

      return error;
    } catch (e) {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  final profileFormKey = GlobalKey<FormState>();

  String bloodGroupValue = 'Unknown';

  String genderValue = 'Female';

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final middleName = TextEditingController();
  final email = TextEditingController();
  final subCounty = TextEditingController();


  Future<void> pickDate(AppState provider) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cancel').onTap(() {
                  provider.init();
                  Navigator.pop(context);
                }),
                Text('Confirm').onTap(() => Navigator.pop(context))
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 16),
            Container(
                height: 200,
                padding: const EdgeInsets.all(8),
                child: ScrollDatePicker(
                  maximumDate: DateTime(3000),
                  minimumDate: DateTime(1000),
                  options: DatePickerOptions(),
                  selectedDate: provider.selectedDate,
                  locale: Locale('en'),
                  onDateTimeChanged: (DateTime value) {
                    provider.setDate(value);
                  },
                )),
          ],
        ).withHeight(350);
      },
    );
  }

  Future<void> pickCounty(AppState provider) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
            itemCount: MLJSON.counties.length,
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(MLJSON.counties[index]['name']),
                trailing: Icon(Icons.chevron_right),
                onTap: (() {
                  provider.setResidence(MLJSON.counties[index]['name']);
                  Navigator.pop(context);
                }),
              ).paddingAll(8);
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);
    final appState = Provider.of<AppState>(context);

        provider.isLoading ? Loader.show(context) : Loader.hide();


    TextEditingController dateOfBirth = TextEditingController(
      text: DateFormat('dd-MM-yyyy').format(appState.selectedDate),
    );

    final countyOfResidence = TextEditingController(
      text: appState.selectedResidence,
    );

    return Form(
      key: profileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('First Name*', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "first_name").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            controller: firstName,
            decoration: InputDecoration(
              hintText: mlFirst_name!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),

          Text('Middle Name', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "middle_name").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            controller: middleName,
            decoration: InputDecoration(
              hintText: mlMiddle_name!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
            textFieldType: TextFieldType.NAME,
          ),
 
          Text('Last Name*', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "last_name").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            controller: lastName,
            textFieldType: TextFieldType.NAME,
            decoration: InputDecoration(
              hintText: mlLast_name!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          Text('Email', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "last_name").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            controller:  email,
            textFieldType: TextFieldType.EMAIL,
            decoration: InputDecoration(
              hintText: mlEmail!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          Text('County of residence*', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "residence").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            readOnly: true,
            controller: countyOfResidence,
            onTap: () async => pickCounty(appState),
            textFieldType: TextFieldType.NAME,
            decoration: InputDecoration(
              hintText: mlResidence!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height,
          Text('Sub county*', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "residence").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },

            controller: subCounty,
            onTap: () async => pickCounty(appState),
            textFieldType: TextFieldType.NAME,
            decoration: InputDecoration(
              hintText: mlResidence!,
              hintStyle: secondaryTextStyle(size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height,
          Text('Day of Birth*', style: primaryTextStyle()),
          AppTextField(
            validator: (value) {
              final error = extractError(provider, "date_of_birth").toString();

              if (error.isNotEmpty) {
                return error;
              }

              return null;
            },
            onTap: () async {
              pickDate(appState);
            },
            readOnly: true,
            controller: dateOfBirth,
            textFieldType: TextFieldType.OTHER,
            decoration: InputDecoration(
              hintText: mlDate_format!,
              hintStyle: secondaryTextStyle(size: 16),
              suffixIcon:
                  Icon(Icons.calendar_today_outlined, color: mlColorBlue),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
              ),
            ),
          ),
          16.height,

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              genderDropDown().expand(flex: 5),
              24.width,
              bloodGroupDropDown().expand(flex: 5),
            ],
          ),
          16.height,
          AppButton(
            height: 50,
            width: context.width(),
            color: mlPrimaryColor,
            onTap: () async {
              hideKeyboard(context);
              await provider.init();
              if (profileFormKey.currentState!.validate()) {

                await provider.postForm(body: {
                  //"username": "string",
                  "first_name": firstName.text.trim(),
                  "middle_name": middleName.text.trim(),
                  "last_name": lastName.text.trim(),
                  "gender": genderValue,
                  "blood_group": bloodGroupValue,
                  "date_of_birth": dateOfBirth.text.trim(),
                  // "nationality": "string",
                  // "occupation": "string",
                  "county_of_residence": countyOfResidence.text.trim(),
                  "sub_county": subCounty.text.trim()
                  // "user_id": 0
                }, uri: Uri.parse(createProfile), token: appState.authCredentials?['data']['token'] ?? '');
              }

              if (profileFormKey.currentState!.validate()) {
                if (provider.success) {
                  await setValue('profile', provider.successMap);
                  appState.initializeProfileInfo(provider.successMap);
                  MLDashboardScreen().launch(context,
                      isNewTask: true,
                      pageRouteAnimation: PageRouteAnimation.Slide);
                }
              }
            },
            child: Text('Save', style: boldTextStyle(color: white)),
          ),
        ],
      ),
    );
  }

  Widget genderDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: primaryTextStyle()),
        DropdownButton<String>(
          value: genderValue,
          icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
              .paddingOnly(left: 74.0),
          iconSize: 24,
          elevation: 16,
          style: secondaryTextStyle(size: 16),
          onChanged: (String? newValue) {
            setState(
              () {
                genderValue = newValue!;
              },
            );
          },
          items: <String>[
            'Female',
            'Male',
            'Custom',
          ].map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: secondaryTextStyle(size: 16)));
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget bloodGroupDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Blood Group', style: primaryTextStyle()),
        Container(
          constraints: BoxConstraints(minWidth: context.width() / 2.5),
          child: DropdownButton<String>(
            value: bloodGroupValue,
            icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
                .paddingOnly(left: 74.0),
            iconSize: 24,
            elevation: 16,
            style: secondaryTextStyle(size: 16),
            onChanged: (String? newValue) {
              setState(() {
                bloodGroupValue = newValue!;
              });
            },
            items: <String>[
              'A+',
              'A-',
              'B+',
              'B-',
              'O+',
              'O-',
              'Unknown',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: secondaryTextStyle(size: 16)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
