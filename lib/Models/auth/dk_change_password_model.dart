class DKChangePasswordErrorModel {
  int? statusCode;
  String? name;
  String? message;
  Errors? errors;

  DKChangePasswordErrorModel(
      {this.statusCode, this.name, this.message, this.errors});

  DKChangePasswordErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    name = json['name'];
    message = json['message'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
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
  List<String>? currentPassword;
  List<String>? newPassword;
  List<String>? confirmPassword;

  Errors({this.currentPassword, this.newPassword, this.confirmPassword});

  Errors.fromJson(Map<String, dynamic> json) {
    currentPassword = json['current_password'].cast<String>();
    newPassword = json['new_password'].cast<String>();
    confirmPassword = json['confirm_password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_password'] = currentPassword;
    data['new_password'] = newPassword;
    data['confirm_password'] = confirmPassword;
    return data;
  }
}