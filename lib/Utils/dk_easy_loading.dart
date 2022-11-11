import 'package:flutter_easyloading/flutter_easyloading.dart';

class DKEasyLoading {
  static void show(){
    EasyLoading.show(dismissOnTap: false, maskType: EasyLoadingMaskType.black);
  }
}