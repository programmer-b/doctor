import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKToast {
  static void toastTop(String message,
      {Color bgColor = Colors.green, dynamic length = Toast.LENGTH_SHORT}) {
    toast(gravity: ToastGravity.TOP, bgColor: bgColor, message, length: length);
  }

  static void showErrorToast(String message) {
    toastTop(message, bgColor: Colors.red, length: Toast.LENGTH_LONG);
  }
}
