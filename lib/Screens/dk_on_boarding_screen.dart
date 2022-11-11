import 'package:afyadaktari/Commons/dk_assets.dart';
import 'package:afyadaktari/Commons/dk_colors.dart';
import 'package:afyadaktari/Commons/dk_strings.dart';
import 'package:afyadaktari/Components/dk_build_onboarding.dart';
import 'package:afyadaktari/Screens/dk_auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DKOnBoardingScreen extends StatefulWidget {
  const DKOnBoardingScreen({super.key});

  @override
  State<DKOnBoardingScreen> createState() => _DKOnBoardingScreenState();
}

class _DKOnBoardingScreenState extends State<DKOnBoardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(bottom: 80),
          child: PageView(
            controller: controller,
            onPageChanged: (value) =>
                value == 2 ? setState(() => isLastPage = true) : null,
            children: [
              DKBuildOnBoarding(
                  color: Colors.blue[50]!,
                  urlImage: dkSlideOne,
                  title: dkAppointment,
                  subtitle: dkAppointmentDesc),
              DKBuildOnBoarding(
                  color: Colors.blue[100]!,
                  urlImage: dkSlideTwo,
                  title: dkConsultation,
                  subtitle: dkConsultationDesc),
              DKBuildOnBoarding(
                  color: Colors.blue[200]!,
                  urlImage: dkSlideThree,
                  title: dkAbout,
                  subtitle: dkAboutDesc),
            ],
          ),
        ),
        bottomSheet: isLastPage
            ? TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    backgroundColor: dkPrimaryColor,
                    minimumSize: const Size.fromHeight(80)),
                onPressed: () => WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) => const DKAuthScreen().launch(context,
                        isNewTask: true,
                        pageRouteAnimation: PageRouteAnimation.Slide)),
                child: Text(dkGetStarted,
                    style: boldTextStyle(color: Colors.white)))
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => controller.jumpToPage(2),
                        child: Text(dkSkip,
                            style: boldTextStyle(color: dkPrimaryColor))),
                    Center(
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: 3,
                        effect: WormEffect(
                          spacing: 16,
                          dotColor: Colors.black26,
                          activeDotColor: dkPrimaryColor,
                        ),
                        onDotClicked: (index) => controller.animateToPage(index,
                            duration: 500.milliseconds, curve: Curves.easeIn),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.nextPage(
                            duration: 500.milliseconds,
                            curve: Curves.easeInOut),
                        child: Text(dkNext,
                            style: boldTextStyle(color: dkPrimaryColor)))
                  ],
                ),
              ),
      );
}
