class DKOTPErrorsModel {
  int? statusCode;
  String? name;
  String? message;
  Errors? errors;

  DKOTPErrorsModel({this.statusCode, this.name, this.message, this.errors});

  DKOTPErrorsModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? oTP;

  Errors({this.oTP});

  Errors.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['OTP'] = oTP;
    return data;
  }
}
