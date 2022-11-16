import 'package:afyadaktari/Commons/dk_images.dart';
import 'package:afyadaktari/Provider/dk_profile_data_provider.dart';
import 'package:afyadaktari/Screens/dk_profile_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/dk_strings.dart';

class DKHomeProfileHead extends StatelessWidget {
  const DKHomeProfileHead({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => const DKProfileScreen().launch(context),
      child: Consumer<DKProfileDataProvider>(builder: (context, value, child) {
        return Row(
          children: [
            CachedNetworkImage(
              imageUrl: dkDummyProfileImage,
              imageBuilder: (context, imageProvider) => Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
              placeholder: (context, url) => const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            8.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi ${value.firstName}",
                    style: boldTextStyle(color: whiteColor)),
                4.height,
                Text(dkWelcome,
                    style: secondaryTextStyle(color: white.withOpacity(0.7))),
              ],
            ),
          ],
        );
      }),
    );
  }
}
