import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:doctor/main.dart';
import 'package:doctor/model/MLInboxData.dart';
import 'package:doctor/screens/PurchaseMoreScreen.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLCommon.dart';
import 'package:doctor/utils/MLDataProvider.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:nb_utils/nb_utils.dart';

class MLChatScreen extends StatefulWidget {
  @override
  MLChatScreenState createState() => MLChatScreenState();
}

class MLChatScreenState extends State<MLChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<MLInboxData> data = mlInboxChatDataList();

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
            Positioned(
              top: 8.0,
              child: Row(
                children: [
                  mlBackToPreviousWidget(context, white),
                  8.width,
                  Stack(children: [
                    CircleAvatar(
                      backgroundColor: mlColorLightGrey,
                      radius: 24,
                      child: Image.asset(ml_ic_doctor_image!, fit: BoxFit.cover)
                          .cornerRadiusWithClipRRect(30.0),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 6,
                      child: Icon(Icons.brightness_1_rounded,
                          color: Colors.greenAccent, size: 14),
                    )
                  ]),
                  8.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. Miranda Kerr',
                          style: boldTextStyle(color: whiteColor, size: 18)),
                      4.height,
                      Text('Online',
                          style: secondaryTextStyle(
                              size: 16, color: white.withOpacity(0.5))),
                    ],
                  )
                ],
              ).paddingAll(16.0),
            ),
            Container(
              margin: EdgeInsets.only(top: 90),
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radiusOnly(topRight: 32),
                backgroundColor: appStore.isDarkModeOn ? black : white,
              ),
              width: context.width(),
              height: context.height(),
              child: PurchaseMoreScreen(),
            ).paddingTop(8.0),
          ],
        ),
        bottomNavigationBar: Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: context.cardColor,
            borderRadius: radius(0.0),
            border: Border.all(color: mlColorLightGrey100),
          ),
          child: Row(
            children: [
              16.width,
              Icon(CupertinoIcons.smiley,
                  size: 22, color: Colors.grey.shade600),
              8.width,
              Icon(Icons.image_outlined, size: 22, color: Colors.grey.shade600),
              8.width,
              Icon(Icons.mic_none, size: 22, color: Colors.grey.shade600),
              8.width,
              AppTextField(
                controller: messageController,
                textFieldType: TextFieldType.OTHER,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write a reply...',
                  hintStyle: secondaryTextStyle(size: 16),
                ),
              ).expand(),
              Icon(Icons.send_outlined, size: 24, color: Colors.blue)
                  .paddingAll(4.0)
                  .onTap(
                () {
                  addMessage();
                  messageController.clear();
                },
              ),
              8.width,
            ],
          ),
        ),
      ),
    );
  }

  void addMessage() {
    setState(
      () {
        data.insert(0, MLInboxData(id: 0, message: messageController.text));
      },
    );
  }
}
