import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nb_utils/nb_utils.dart';

class DKLoadingComponent extends StatelessWidget {
  const DKLoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: AspectRatio(
        aspectRatio: context.pixelRatio(),
        child: Center(
          child: SpinKitFadingCircle(
            color: dkPrimaryColor,
          ),
        ),
      ),
    );
  }
}
