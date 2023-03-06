import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Components/dk_button_component.dart';
import 'package:afyadaktari/Components/dk_success_anim.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../Commons/dk_strings.dart';

class DKBookResults extends StatefulWidget {
  const DKBookResults({super.key});

  @override
  State<DKBookResults> createState() => _DKBookResultsState();
}

class _DKBookResultsState extends State<DKBookResults> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(dkSuccess, style: boldTextStyle(size: 24),),
            18.height,
            const Icon(Icons.check_circle, color: Colors.green, size: 100,),
            12.height,
            Text(dkAppointBookSuccessMsg, style: boldTextStyle(size: 18), textAlign: TextAlign.center),
            24.height,
            DKButtonComponent(onTap: () => finish(context), text: dkOk, gradient: dkSubmitButtonGradient,)
          ],
        ),
      ),
    );
  }
}
