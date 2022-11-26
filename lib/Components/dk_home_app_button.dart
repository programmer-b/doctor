import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_lists.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DkHomeAppButton extends StatelessWidget {
  const DkHomeAppButton({super.key, required this.image, required this.title, required this.index});
  final String image;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Widget route = homeApplications["apps"][index]["route"];
    return Container(
      padding: const EdgeInsets.all(8),
      width: 150,
      decoration: BoxDecoration(
          color: dkPrimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              image,
              height: 32,
              width: 32,
              fit: BoxFit.cover,
            ),
            Text(
              title,
              style: boldTextStyle(color: Colors.white, size: 13),
            )
          ],
        ),
      ),
    ).onTap(()=> route.launch(context));
  }
}
