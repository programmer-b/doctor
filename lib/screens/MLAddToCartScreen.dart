import 'package:flutter/material.dart';
import 'package:doctor/main.dart';
import 'package:doctor/screens/PurchaseMoreScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'MLConfirmOrderScreen.dart';

class MLAddToCartScreen extends StatefulWidget {
  static String tag = '/MLShoppingCartScreen';

  @override
  MLAddToCartScreenState createState() => MLAddToCartScreenState();
}

class MLAddToCartScreenState extends State<MLAddToCartScreen> {
  int currentWidget = 0;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: Stack(
          children: [
            Container(
              height: context.height(),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    8.height,
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: appStore.isDarkModeOn ? white : blackColor,
                          size: 22,
                        ).onTap(
                          () {
                            currentWidget == 0
                                ? Navigator.of(context).pop()
                                : setState(
                                    () {
                                      currentWidget--;
                                    },
                                  );
                          },
                        ),
                        currentWidget == 0
                            ? Row(
                                children: [
                                  Text('Shopping Cart',
                                      style: boldTextStyle(size: 24)),
                                  8.width,
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: boxDecorationWithRoundedCorners(
                                      backgroundColor: mlColorDarkBlue,
                                      boxShape: BoxShape.circle,
                                    ),
                                    child: Text('3',
                                        style: secondaryTextStyle(
                                            size: 18, color: white)),
                                  ),
                                ],
                              )
                            : Text('Check Out', style: boldTextStyle(size: 22)),
                      ],
                    ).paddingAll(16.0),
                    8.height,
                    PurchaseMoreScreen().withHeight(context.height() * 0.8),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: context.width(),
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radius(0.0),
                  backgroundColor: context.cardColor,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 0.0),
                  ],
                ),
                child: currentWidget == 0
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          8.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total',
                                  style: secondaryTextStyle(size: 16)),
                              Text('\$250.00', style: boldTextStyle()),
                            ],
                          ),
                          32.width,
                          AppButton(
                            color: mlColorDarkBlue,
                            onTap: () {
                              setState(
                                () {
                                  currentWidget++;
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Check Out',
                                    style: boldTextStyle(color: white)),
                                4.width,
                                Icon(Icons.arrow_forward_ios,
                                    color: white, size: 16),
                              ],
                            ),
                          ).expand()
                        ],
                      )
                    : AppButton(
                        color: mlColorDarkBlue,
                        width: context.width() / 2,
                        onTap: () {
                          setState(
                            () {
                              MLConfirmOrderScreen().launch(context);
                            },
                          );
                        },
                        child:
                            Text('Confirm', style: boldTextStyle(color: white)),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
