import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/components/MLPIllHowToUseComponent.dart';
import 'package:doctor/components/MLPillDetailComponent.dart';
import 'package:doctor/components/MLPillReviewComponent.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/main.dart';

class MLProductMoreDetailScreen extends StatefulWidget {
  static String tag = '/MLProductMoreDetailScreen';

  @override
  MLProductMoreDetailScreenState createState() =>
      MLProductMoreDetailScreenState();
}

class MLProductMoreDetailScreenState extends State<MLProductMoreDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: boxDecorationWithRoundedCorners(
            borderRadius: radiusOnly(topRight: 32),
            backgroundColor: appStore.isDarkModeOn ? black : white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              24.height,
              Icon(Icons.close, color: mlColorBlue).paddingRight(32.0).onTap(
                () {
                  finish(context);
                },
              ),
              24.height,
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: radiusOnly(topRight: 32),
                  backgroundColor: context.cardColor,
                ),
                height: context.height(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: mlColorBlue,
                      indicatorColor: mlColorBlue,
                      unselectedLabelColor: Colors.grey,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: primaryTextStyle(),
                      tabs: [
                        Tab(text: 'Detail'),
                        Tab(text: 'How to Use'),
                        Tab(text: 'Review'),
                      ],
                    ),
                    TabBarView(
                      controller: _tabController,
                      children: [
                        MLPillDetailComponent(),
                        MLPillHowToUseComponent(),
                        MLPillReviewComponent(),
                      ],
                    ).expand(),
                  ],
                ),
              ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}
