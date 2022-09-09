import 'package:doctor/State/app_state.dart';
import 'package:doctor/components/MLContiesComponent.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';

class MLProfileFormComponent extends StatefulWidget {
  static String tag = '/MLProfileFormComponent';

  @override
  MLProfileFormComponentState createState() => MLProfileFormComponentState();
}

class MLProfileFormComponentState extends State<MLProfileFormComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //  @override
    context
        .read<AppState>()
        .MLget(Uri.parse("https://counties-kenya.herokuapp.com/api/v1"));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  String dropdownValue = 'Female';
  String bloodGroupValue = 'A+';
  TextEditingController dateOfBirth =
      TextEditingController(text: DateFormat.yMd().format(DateTime.now()));

  final date = DateTime.now();

  Future<void> showBottomSheet(context, AppState provider) async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
              itemCount: provider.successMap.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    provider.countyResidenceUpdate(
                        provider.successMap[index]['name']);
                    Navigator.pop(context);
                  },
                  title: Text(provider.successMap[index]['name']),
                  trailing: Icon(Icons.chevron_right),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppState>(context);
    TextEditingController residence =
        TextEditingController(text: context.read<AppState>().countyResidence);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('First Name*', style: primaryTextStyle()),
        AppTextField(
          decoration: InputDecoration(
            hintText: mlFirst_name!,
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
            ),
          ),
          textFieldType: TextFieldType.NAME,
        ),
        16.height,
        Text('Middle Name', style: primaryTextStyle()),
        AppTextField(
          decoration: InputDecoration(
            hintText: mlMiddle_name!,
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
            ),
          ),
          textFieldType: TextFieldType.NAME,
        ),
        16.height,
        Text('Last Name*', style: primaryTextStyle()),
        AppTextField(
          textFieldType: TextFieldType.NAME,
          decoration: InputDecoration(
            hintText: mlLast_name!,
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
            ),
          ),
        ),
        Text('Residence*', style: primaryTextStyle()),
        AppTextField(
          controller: residence,
          readOnly: true,
          onTap: () async => showBottomSheet(context, provider),
          textFieldType: TextFieldType.NAME,
          decoration: InputDecoration(
            hintText: mlResidence!,
            hintStyle: secondaryTextStyle(size: 16),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
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
              dateOfBirth =
                  TextEditingController(text: DateFormat.yMd().format(newDate));
            });
          },
          readOnly: true,
          controller: dateOfBirth,
          textFieldType: TextFieldType.OTHER,
          decoration: InputDecoration(
            hintText: mlDate_format!,
            hintStyle: secondaryTextStyle(size: 16),
            suffixIcon: Icon(Icons.calendar_today_outlined, color: mlColorBlue),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: mlColorLightGrey.withOpacity(0.2)),
            ),
          ),
        ),
        16.height,
        Text('Phone Number*', style: primaryTextStyle()),
        Row(
          children: [
            AppTextField(
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
      ],
    );
  }

  Widget genderDropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender', style: primaryTextStyle()),
        DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.keyboard_arrow_down, color: mlColorBlue)
              .paddingOnly(left: 74.0),
          iconSize: 24,
          elevation: 16,
          style: secondaryTextStyle(size: 16),
          onChanged: (String? newValue) {
            setState(
              () {
                dropdownValue = newValue!;
              },
            );
          },
          items: <String>[
            'Female',
            'Male',
            'Other',
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
              'None',
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
