import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../Components/dk_custom_dialog.dart';
import 'dk_strings.dart';

extension SnapshotReady on AsyncSnapshot {
  bool get ready {
    return connectionState == ConnectionState.done;
  }
}

extension ValueIsNull on dynamic {
  bool get isNull => this == 0 || this == null || this == false || this == '';
}

extension IsOk on http.Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

extension StringExtensions on String {
  bool isNumber(String item) {
    return split('').contains(item);
  }

  Uri get toUri => Uri.parse(this);
}

extension BuildContextExtensions on BuildContext {
  get restart {
    RestartAppWidget.init(this);
  }

  Future<void> get logout async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    restart;
  }

  Future<void> showLogOut() async {
    await showDialog(
        context: this,
        builder: (context) => DKCustomDialog(
              title: dkLogOut,
              content: dkLogOutMsg,
              positiveText: dkLogOut,
              onTap: () => logout,
            ));
  }
}
