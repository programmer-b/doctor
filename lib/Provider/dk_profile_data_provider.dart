import 'dart:convert';
import 'dart:developer';

import 'package:afyadaktari/Commons/dk_extensions.dart';
import 'package:afyadaktari/Commons/dk_keys.dart';
import 'package:afyadaktari/Commons/dk_urls.dart';
import 'package:afyadaktari/Functions/auth_functions.dart';
import 'package:afyadaktari/Models/auth/dk_user_token_decode_model.dart';
import 'package:afyadaktari/Utils/dk_easy_loading.dart';
import 'package:afyadaktari/Utils/dk_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:http/http.dart' as http;

import '../Models/auth/dk_profile_error_model.dart';

class DKProfileDataProvider extends ChangeNotifier {
  String _firstName = "";
  String get firstName => _firstName;

  void setFirstName(text) {
    _firstName = text;
    notifyListeners();
  }

  String _middleName = "";
  String get middleName => _middleName;

  void setMiddleNameName(text) {
    _middleName = text;
    notifyListeners();
  }

  String _lastName = "";
  String get lastName => _lastName;

  void setLastName(text) {
    _lastName = text;
    notifyListeners();
  }

  String _email = "";
  String get email => _email;

  void setEmail(text) {
    _email = text;
    notifyListeners();
  }

  String _countyOfResidence = "";
  String get countyOfResidence => _countyOfResidence;

  void setCountyOfResidence(text) {
    _countyOfResidence = text;
    notifyListeners();
  }

  String _subCountyOfResidence = "";
  String get subCountyOfResidence => _subCountyOfResidence;

  void setSubCountyOfResidence(text) {
    _subCountyOfResidence = text;
    notifyListeners();
  }

  String _dateOfBirth = "";
  String get dateOfBirth => _dateOfBirth;

  void setDateOfBirth(text) {
    _dateOfBirth = text;
    notifyListeners();
  }

  String _bloodGroup = "";
  String get bloodGroup => _bloodGroup;

  void setBloodGroup(text) {
    _bloodGroup = text;
    notifyListeners();
  }

  String _gender = "";
  String get gender => _gender;

  void setGender(text) {
    _gender = text;
    notifyListeners();
  }

  DateTime _selectedDate = now;
  DateTime get selectedDate => _selectedDate;

  void initDates() {
    _selectedDate = now;
    notifyListeners();
  }

  void confirmDate() {
    _dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);
    notifyListeners();
  }

  void setDate(newDate) {
    _selectedDate = newDate;
    _dateOfBirth = DateFormat('yyyy-MM-dd').format(selectedDate);

    notifyListeners();
  }

  String _selectedResidence = '';
  String get selectedResidence => _selectedResidence;

  void setResidence(residence) {
    _selectedResidence = residence;
    notifyListeners();
  }

  Future<void> submitData() async {
    DKEasyLoading.show();

    _firstName = _firstName.trim();
    _middleName = _middleName.trim();
    _lastName = _lastName.trim();
    _dateOfBirth = _dateOfBirth.trim();
    _gender = _gender.trim();
    _bloodGroup = _bloodGroup.trim();
    _countyOfResidence = _countyOfResidence.trim();
    _subCountyOfResidence = _subCountyOfResidence.trim();
    _email = _email.trim();

    final Map<String, String> body = {
      keyFirstName: _firstName,
      keyMiddleName: _middleName,
      keyLastName: _lastName,
      keyDateOfBirth: _dateOfBirth,
      keyGender: _gender,
      keyBloodGroup: _bloodGroup,
      keyCountyOfResidence: _countyOfResidence,
      keySubCounty: _subCountyOfResidence,
      keyEmail: _email,
    };

    final token = getStringAsync(keyToken);
    final DKUserTokenDecodeModel decodedToken = decodeJWT(token);

    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final int profileId = decodedToken.usr?.profile?.id ?? 0;

    final uri = Uri.parse("$dkProfileUrl/$profileId");

    try {
      final response = await http.put(uri, body: body, headers: headers);
      log(response.body);
      if (response.ok) {
        await refreshToken();
        EasyLoading.showSuccess(jsonDecode(response.body)[keyMessage]);
        _success = true;
      } else {
        _profileErrors =
            DKProfileErrorModel.fromJson(jsonDecode(response.body));
      }
      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      DKToast.showErrorToast("$e");
      rethrow;
    }
  }

  DKProfileErrorModel? _profileErrors;
  DKProfileErrorModel? get profileErrors => _profileErrors;

  bool _success = false;
  bool get success => _success;

  void init() {
    _profileErrors = null;
    notifyListeners();
  }

  void initialize() {
    _profileErrors = null;
    _firstName = "";
    _middleName = "";
    _lastName = "";
    _dateOfBirth = "";
    _countyOfResidence = "";
    _subCountyOfResidence = "";
    _gender = "";
    _bloodGroup = "";
    notifyListeners();
  }

  void setProfile() {
    final String token = getStringAsync(keyToken);
    final profile = decodeJWT(token);

    _firstName = profile.usr?.profile?.firstName;
    _middleName = profile.usr?.profile?.middleName ?? "";
    _lastName = profile.usr?.profile?.lastName;
    _email = profile.usr?.profile?.email ?? "";
    _countyOfResidence = profile.usr?.profile?.countyOfResidence;
    _subCountyOfResidence = profile.usr?.profile?.subCounty;
    _bloodGroup = profile.usr?.profile?.bloodGroup;
    _gender = profile.usr?.profile?.gender;
    _dateOfBirth = profile.usr?.profile?.dateOfBirth;

    notifyListeners();
  }

  DKUserTokenDecodeModel get profile {
    final String token = getStringAsync(keyToken);
    return decodeJWT(token);
  }
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);
