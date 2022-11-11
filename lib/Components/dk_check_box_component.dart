import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Provider/dk_login_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DKShowHidePasswordCheckBox extends StatelessWidget {
  const DKShowHidePasswordCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: dkPrimaryColor,
            value: !context.watch<DKLoginDataProvider>().canShowPassword,
            onChanged: (value) =>
                context.read<DKLoginDataProvider>().showPassword(),
          ),
          Text(
            dkShowPasswordText,
            style: primaryTextStyle( size: 17),
          )
        ],
      ),
    );
  }
}
