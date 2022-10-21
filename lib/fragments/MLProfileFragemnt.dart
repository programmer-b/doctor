import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor/state/appstate.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/components/MLProfileBottomComponent.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:doctor/utils/MLImage.dart';
import 'package:provider/provider.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';

  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
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
    final appState = Provider.of<AppState>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: mlPrimaryColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 225,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: mlColorDarkBlue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://cdn-icons-png.flaticon.com/128/1177/1177568.png',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      8.height,
                      Text(
                          '${appState.profileInfo?["data"]["first_name"] ?? appState.profileInfo?["data"]["dataModels"][0]["first_name"] ?? ""} ${appState.profileInfo?["data"]["last_name"] ?? appState.profileInfo?["data"]["dataModels"][0]["last_name"] ?? ""}',
                          style: boldTextStyle(color: white, size: 24)),
                      4.height,
                      Text(
                          '${appState.profileInfo?["data"]["email"] ?? appState.authCredentials?["data"]["phone number"]}',
                          style: secondaryTextStyle(color: white, size: 16)),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return MLProfileBottomComponent();
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
