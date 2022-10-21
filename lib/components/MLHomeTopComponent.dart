import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:doctor/model/MLServiceData.dart';
import 'package:doctor/screens/MLAddToCartScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLDataProvider.dart';
import 'package:doctor/utils/MLString.dart';
import 'package:provider/provider.dart';

class MLHomeTopComponent extends StatefulWidget {
  static String tag = '/MLHomeTopComponent';

  @override
  _MLHomeTopComponentState createState() => _MLHomeTopComponentState();
}

class _MLHomeTopComponentState extends State<MLHomeTopComponent> {
  int counter = 2;
  List<MLServicesData> data = mlServiceDataList();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    log("AUTH: ${appState.authCredentials}\nPROFILE:  ${appState.profileInfo}");
    return Container(
      height: 260,
      width: context.width(),
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: mlColorDarkBlue,
        borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 80.0)),
      ),
      child: Column(
        children: [
          16.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://cdn-icons-png.flaticon.com/128/1177/1177568.png',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "Hi ${appState.profileInfo?["data"]["first_name"] ?? appState.profileInfo?["data"]["dataModels"][0]["first_name"] ?? "User"}",
                          style: boldTextStyle(color: whiteColor)),
                      4.height,
                      Text(mlWelcome!,
                          style: secondaryTextStyle(
                              color: white.withOpacity(0.7))),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.search, color: white, size: 24),
                  10.width,
                  Stack(
                    children: [
                      Icon(Icons.shopping_bag_outlined, color: white, size: 24),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: boxDecorationWithRoundedCorners(
                              backgroundColor: mlColorRed),
                          constraints:
                              BoxConstraints(minWidth: 12, minHeight: 12),
                          child: Text(
                            counter.toString(),
                            style: boldTextStyle(size: 8, color: white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ).onTap(() {
                    MLAddToCartScreen().launch(context);
                  }),
                ],
              )
            ],
          ).paddingOnly(right: 16.0, left: 16.0),
          Container(
            margin: EdgeInsets.only(right: 16.0, left: 16.0),
            transform: Matrix4.translationValues(0, 16.0, 0),
            alignment: Alignment.center,
            decoration: boxDecorationRoundedWithShadow(12,
                backgroundColor: context.cardColor),
            child: Wrap(
              alignment: WrapAlignment.center,
              direction: Axis.horizontal,
              spacing: 8.0,
              children: data.map(
                (e) {
                  return Container(
                    constraints:
                        BoxConstraints(minWidth: context.width() * 0.25),
                    padding: EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Column(
                      children: [
                        Image.asset(e.image!,
                            width: 28, height: 28, fit: BoxFit.fill),
                        8.height,
                        Text(e.title.toString(),
                            style: boldTextStyle(size: 12),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ).onTap(
                    () {
                      e.widget.launch(context);
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
