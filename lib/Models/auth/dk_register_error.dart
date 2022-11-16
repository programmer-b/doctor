class DKRegisterErrorModel {
  int? statusCode;
  String? name;
  String? message;
  Errors? errors;

  DKRegisterErrorModel({this.statusCode, this.name, this.message, this.errors});

  DKRegisterErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    name = json['name'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['name'] = name;
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<dynamic>? username;
  List<dynamic>? mobile;
  List<dynamic>? confirmMobile;
  List<dynamic>? password;
  List<dynamic>? confirmPassword;

  Errors({this.username, this.mobile, this.password, this.confirmPassword, this.confirmMobile});

  Errors.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    mobile = json['mobile'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    confirmMobile = json['confirm_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['mobile'] = mobile;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}
