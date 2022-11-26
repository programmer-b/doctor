class DKMobileErrorModel {
  int? statusCode;
  String? name;
  String? message;
  Errors? errors;

  DKMobileErrorModel({this.statusCode, this.name, this.message, this.errors});

  DKMobileErrorModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? mobile;

  Errors({this.mobile});

  Errors.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    return data;
  }
}