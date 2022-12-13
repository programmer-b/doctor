import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/enums.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DKRoleProvider extends ChangeNotifier {
  Roles role = Roles.admin;

  void setRole(Roles role) async {
    this.role = role;

    switch (role) {
      case Roles.admin:
        storeRole(keyAdmin);
        break;
      case Roles.patient:
        storeRole(keyPatient);
        break;
      case Roles.doctor:
        storeRole(keyDoctor);
        break;
    }

    notifyListeners();
  }

  Future storeRole(String role) async => await setValue(keyRole, role);
  String get currentRole => getStringAsync(keyRole);

  void awakenRole() {
    switch (currentRole) {
      case keyAdmin:
        role = Roles.admin;
        break;
      case keyPatient:
        role = Roles.patient;
        break;
      case keyDoctor:
        role = Roles.doctor;
        break;
    }
    notifyListeners();
  }

  static Roles getCurrentRole(String role) {
    switch (role) {
      case keyAdmin:
        return Roles.admin;
      case keyPatient:
        return Roles.patient;
      case keyDoctor:
        return Roles.doctor;
      default:
        return Roles.admin;
    }
  }
}
