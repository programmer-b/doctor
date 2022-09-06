import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/utils/MLColors.dart';

class MLCountryPickerComponent extends StatefulWidget {
  static String tag = '/MLCountryPickerComponent';

  @override
  MLCountryPickerComponentState createState() =>
      MLCountryPickerComponentState();
}

class MLCountryPickerComponentState extends State<MLCountryPickerComponent> {
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
    return Column(
      children: [
        6.height,
        Row(
          children: [
            CountryCodePicker(
              onChanged: log,
              initialSelection: 'IT',
              favorite: ['+1', 'US'],
              showFlag: false,
              alignLeft: false,
              padding: EdgeInsets.all(0),
            ),
            2.width,
            Icon(Icons.arrow_drop_down, size: 16).paddingRight(0.0),
          ],
        ),
        8.height,
        Container(
            width: 75, height: 1, color: mlColorLightGrey.withOpacity(0.2))
      ],
    );
  }
}
