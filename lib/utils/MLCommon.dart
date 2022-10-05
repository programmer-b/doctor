import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:doctor/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:doctor/utils/MLColors.dart';
import 'package:http/http.dart' as http;

Widget mlBackToPrevious(BuildContext context, Color color) {
  return Align(
    alignment: Alignment.topLeft,
    child: Icon(Icons.arrow_back_ios, color: color, size: 22),
  ).paddingOnly(top: 24.0, left: 24.0).onTap(() {
    finish(context);
  });
}

Widget mlRoundedIconContainer(IconData iconData, Color color) {
  return Container(
    padding: EdgeInsets.all(6.0),
    decoration: boxDecorationWithRoundedCorners(
      border: Border.all(color: Colors.grey.shade100),
      boxShape: BoxShape.circle,
      backgroundColor: appStore.isDarkModeOn ? scaffoldDarkColor : white,
    ),
    child: Icon(iconData, size: 20, color: color),
  );
}

Widget mlIconWithRoundedContainer(IconData iconData, Color color) {
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: boxDecorationWithRoundedCorners(
        backgroundColor: white,
        border: Border.all(color: Colors.grey.shade100),
        borderRadius: radius(24)),
    child: Icon(iconData, size: 16, color: color),
  );
}

Widget mlSelectedNavigationbarIcon(IconData iconData) {
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.blue.withOpacity(0.1),
        borderRadius: radius(24)),
    child: Icon(iconData, size: 22, color: mlColorDarkBlue),
  );
}

Widget mlBackToPreviousWidget(BuildContext context, Color color) {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(
      icon: Icon(Icons.arrow_back_ios_outlined, color: color, size: 22),
      onPressed: () {
        finish(context);
      },
    ),
  );
}

Widget mlBackToPreviousIcon(BuildContext context, Color color) {
  return Align(
    alignment: Alignment.topLeft,
    child: Icon(Icons.arrow_back_ios_outlined, color: color, size: 18),
  ).onTap(() {
    finish(context);
  });
}

Widget commonCachedNetworkImage(
  String? url, {
  double? height,
  double? width,
  BoxFit? fit,
  AlignmentGeometry? alignment,
  bool usePlaceholderIfUrlEmpty = true,
  double? radius,
  Color? color,
}) {
  if (url!.validate().isEmpty) {
    return placeHolderWidget(
        height: height,
        width: width,
        fit: fit,
        alignment: alignment,
        radius: radius);
  } else if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: url,
      height: height,
      width: width,
      fit: fit,
      color: color,
      alignment: alignment as Alignment? ?? Alignment.center,
      errorWidget: (_, s, d) {
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
      placeholder: (_, s) {
        if (!usePlaceholderIfUrlEmpty) return SizedBox();
        return placeHolderWidget(
            height: height,
            width: width,
            fit: fit,
            alignment: alignment,
            radius: radius);
      },
    );
  } else {
    return Image.asset(url,
            height: height,
            width: width,
            fit: fit,
            alignment: alignment ?? Alignment.center)
        .cornerRadiusWithClipRRect(radius ?? defaultRadius);
  }
}

Widget placeHolderWidget(
    {double? height,
    double? width,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    double? radius}) {
  return Image.asset('images/placeholder.jpg',
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          alignment: alignment ?? Alignment.center)
      .cornerRadiusWithClipRRect(radius ?? defaultRadius);
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

extension IsOk on http.Response {
  bool get OK {
    return (statusCode ~/ 100) == 2;
  }
}

void toastError({dynamic error}){
  toast('$error', bgColor: Colors.red, gravity: ToastGravity.TOP);
}