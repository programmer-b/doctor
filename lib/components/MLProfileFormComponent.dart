import 'package:doctor/screens/MLLoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';

import '../services/networking.dart';

class MLProfileFormComponent extends StatefulWidget {
  MLProfileFormComponent(
      {Key? key,
      required this.dateOfBirthCache,
      required this.phoneNumberCache,
      required this.firstNameCache,
      required this.middleNameCache,
      required this.bloodGroupCache,
      required this.residenceCache,
      required this.lastNameCache,
      required this.genderCache})
      : super(key: key);
  static String tag = '/MLProfileFormComponent';

  final String dateOfBirthCache;
  final String phoneNumberCache;
  final String firstNameCache;
  final String lastNameCache;
  final String middleNameCache;
  final String bloodGroupCache;
  final String residenceCache;
  final String genderCache;

  @override
  MLProfileFormComponentState createState() => MLProfileFormComponentState();
}

class MLProfileFormComponentState extends State<MLProfileFormComponent> {
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

  final date = DateTime.now();

  // Future<void> showBottomSheet(context, AppState provider) async {
  //   await showModalBottomSheet<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return ListView.builder(
  //             itemCount: provider.successMap.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 onTap: () {
  //                   provider.countyResidenceUpdate(
  //                       provider.successMap[index]['name']);
  //                   Navigator.pop(context);
  //                 },
  //                 title: Text(provider.successMap[index]['name']),
  //                 trailing: Icon(Icons.chevron_right),
  //               );
  //             });
  //       });
  // }
  String genderValue = 'Female';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Networking>(context);

    String genderValue =
        widget.genderCache == '' ? 'Female' : widget.genderCache;

    TextEditingController dateOfBirth = TextEditingController(
        text: widget.dateOfBirthCache == ''
            ? DateFormat.yMd().format(DateTime.now())
            : widget.dateOfBirthCache);

    final firstName = TextEditingController(text: widget.firstNameCache);
    final lastName = TextEditingController(text: widget.lastNameCache);
    final middleName = TextEditingController(text: widget.middleNameCache);
    final residence = TextEditingController(text: widget.residenceCache);
    final phoneNumber = TextEditingController(text: widget.phoneNumberCache);

    return Form(
      key: profileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('First Name*', style: primaryTextStyle()),
          AppTextField(
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
          16.height,
          Text('Middle Name', style: primaryTextStyle()),
          AppTextField(
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
          16.height,
          Text('Last Name*', style: primaryTextStyle()),
          AppTextField(
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
          Text('Residence*', style: primaryTextStyle()),
          AppTextField(
            readOnly: true,
            controller: residence,
            onTap: () async => null,
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
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100));

              if (newDate == null) return;

              setState(() {
                dateOfBirth = TextEditingController(
                    text: DateFormat.yMd().format(newDate));
              });
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
          Text('Phone Number*', style: primaryTextStyle()),
          Row(
            children: [
              AppTextField(
                controller: phoneNumber,
                textFieldType: TextFieldType.PHONE,
                decoration: InputDecoration(
                  prefix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('+254', style: boldTextStyle(size: 14)),
                      6.width,
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16,
                      ),
                    ],
                  ),
                  labelText: mlPhoneNumber!,
                  labelStyle: secondaryTextStyle(size: 16),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: mlColorLightGrey.withOpacity(0.2))),
                ),
              ).expand(),
            ],
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

              await provider.postForm(body: {
                //"username": "string",
                "first_name": firstName.text.trim(),
                "last_name": lastName.text.trim(),
                "gender": genderValue,
                "blood_group": bloodGroupValue,
                "phone": phoneNumber.text.trim(),
                // "nationality": "string",
                // "occupation": "string",
                "residence": residence.text.trim(),
                // "user_id": 0
              }, uri: Uri.parse(createProfile));

              if (profileFormKey.currentState!.validate()) {
                if (provider.success) {
                  MLLoginScreen().launch(context,
                      isNewTask: true,
                      pageRouteAnimation: PageRouteAnimation.Slide);
                }
              }
            },
            child: provider.isLoading
                ? Loader(
                    color: mlPrimaryColor,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Text('Save', style: boldTextStyle(color: white)),
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
