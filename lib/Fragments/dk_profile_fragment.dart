import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_lists.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:afyadaktari/Components/dk_date_picker_component.dart';
import 'package:afyadaktari/Components/dk_text_field.dart';
import 'package:afyadaktari/Models/dk_profile_error_model.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DKProfileFragment extends StatefulWidget {
  const DKProfileFragment({super.key});

  @override
  State<DKProfileFragment> createState() => _DKProfileFragmentState();
}

class _DKProfileFragmentState extends State<DKProfileFragment> {
  final List<String> genderItems = ['Male', 'Female', 'Custom'];

  final List<String> bloodGroupItems = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'Unknown',
  ];

  Future<void> _showBottomSheet(Widget child) async {
    await showModalBottomSheet<void>(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        context: context,
        builder: (context) => child);
  }

  Future<void> _pickDate() async {
    await _showBottomSheet(const DKDatePickerComponent());
  }

  Future<void> _pickBloodGroup(context) async {
    await _showBottomSheet(Column(
      children: _listTileItems(context, bloodGroupItems, type: "bloodGroup"),
    ));
  }

  Future<void> _pickGender(BuildContext context) async =>
      await _showBottomSheet(SizedBox(
        height: context.height() * 0.4,
        child: Column(
          children: _listTileItems(context, genderItems, type: "gender"),
        ),
      ));

  Future<void> _pickCounty(BuildContext context) async {
    final child = ListView.builder(
      itemCount: dkCountiesList.length,
      itemBuilder: (context, index) => ListTile(
        leading: Text(
          "${index + 1}",
          style: boldTextStyle(),
        ),
        title: Text(
          dkCountiesList[index]["name"] ?? "",
          style: boldTextStyle(),
        ),
        onTap: () {
          context
              .read<DKProfileDataProvider>()
              .setCountyOfResidence(dkCountiesList[index]["name"] ?? "");
          finish(context);
        },
      ),
    ).paddingAll(8);
    await _showBottomSheet(child);
  }

  List<Widget> _listTileItems(BuildContext context, List values,
          {required String type}) =>
      values
          .map((e) => ListTile(
                title: Text(
                  e,
                  style: boldTextStyle(),
                ),
                onTap: () {
                  switch (type) {
                    case "gender":
                      context.read<DKProfileDataProvider>().setGender(e);
                      finish(context);
                      break;
                    case "bloodGroup":
                      context.read<DKProfileDataProvider>().setBloodGroup(e);
                      finish(context);
                      break;
                    default:
                      finish(context);
                      null;
                  }
                },
              ))
          .toList();

  String? _validate(BuildContext context, String type) {
    final DKProfileErrorModel? errors =
        context.read<DKProfileDataProvider>().profileErrors;

    if (errors != null) {
      switch (type) {
        case keyDateOfBirth:
          List error = errors.errors?.dateOfBirth ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keySubCounty:
          List error = errors.errors?.subCounty ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyFirstName:
          List error = errors.errors?.firstName ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyGender:
          List error = errors.errors?.gender ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyLastName:
          List error = errors.errors?.lastName ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyBloodGroup:
          List error = errors.errors?.bloodGroup ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyCountyOfResidence:
          List error = errors.errors?.countyOfResidence ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyMiddleName:
          List error = errors.errors?.middleName ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
        case keyEmail:
          List error = errors.errors?.email ?? [];
          if (error.isNotEmpty) {
            return error.join(" , ");
          }
          break;
      }
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await 0.seconds.delay;
    if (mounted) {
      context.read<DKProfileDataProvider>().init();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<DKProfileDataProvider>();
    final dateOfBirth = TextEditingController(
        text: context.watch<DKProfileDataProvider>().dateOfBirth);
    final bloodGroup = TextEditingController(
        text: context.watch<DKProfileDataProvider>().bloodGroup);
    final gender = TextEditingController(
        text: context.watch<DKProfileDataProvider>().gender);
    final countyOfResidence = TextEditingController(
        text: context.watch<DKProfileDataProvider>().countyOfResidence);

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            dkCreateYourProfile,
            style: boldTextStyle(size: 22, color: dkPrimaryTextColor),
          ),
        ),
        16.height,
        DKTextField(
          hint: dkFirstName,
          validator: (p0) => _validate(context, keyFirstName),
          onChanged: (text) => provider.setFirstName(text),
        ),
        16.height,
        DKTextField(
          hint: dkMiddleName,
          validator: (p0) => _validate(context, keyMiddleName),
          onChanged: (text) => provider.setMiddleNameName(text),
        ),
        16.height,
        DKTextField(
          hint: dkLastName,
          validator: (p0) => _validate(context, keyLastName),
          onChanged: (text) => provider.setLastName(text),
        ),
        16.height,
        DKTextField(
          hint: dkEmail,
          validator: (p0) => _validate(context, keyEmail),
          keyboardType: TextInputType.emailAddress,
          onChanged: (text) => provider.setEmail(text),
        ),
        16.height,
        DKTextField(
          hint: dkCountyOfResidence,
          validator: (p0) => _validate(context, keyCountyOfResidence),
          controller: countyOfResidence,
          readOnly: true,
          onTap: () => _pickCounty(context),
        ),
        16.height,
        DKTextField(
          hint: dkSubCountyOfResidence,
          validator: (p0) => _validate(context, keySubCounty),
          onChanged: (text) => provider.setSubCountyOfResidence(text),
        ),
        16.height,
        DKTextField(
          hint: dkDateOfBirth,
          validator: (p0) => _validate(context, keyDateOfBirth),
          controller: dateOfBirth,
          onTap: _pickDate,
          readOnly: true,
        ),
        16.height,
        DKTextField(
          hint: dkGender,
          validator: (p0) => _validate(context, keyGender),
          readOnly: true,
          controller: gender,
          onTap: () => _pickGender(context),
        ),
        16.height,
        DKTextField(
          hint: dkBloodGroup,
          validator: (p0) => _validate(context, keyBloodGroup),
          controller: bloodGroup,
          readOnly: true,
          onTap: () => _pickBloodGroup(context),
        ),
        20.height,
        DKButtonComponent(
          text: dkSubmit,
          onTap: () async {
            await provider.submitData();
            if (provider.success) {
              if (mounted) {
                RestartAppWidget.init(context);
              }
            }
          },
          gradient: dkSubmitButtonGradient,
        ),
      ],
    );
  }
}
