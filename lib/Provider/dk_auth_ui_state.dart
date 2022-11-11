import 'package:afyadaktari/Fragments/dk_login_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DkAuthUiState extends ChangeNotifier {
  Widget _currentFragment = const DKLoginFragment();
  Widget get currentFragment => _currentFragment;

  void switchFragment(Widget fragment) {
    _currentFragment = fragment;
    EasyLoading.dismiss();
    
    notifyListeners();
  }
}
