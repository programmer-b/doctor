class DKProfileErrorModel {
  int? statusCode;
  String? name;
  String? message;
  Errors? errors;

  DKProfileErrorModel({this.statusCode, this.name, this.message, this.errors});

  DKProfileErrorModel.fromJson(Map<String, dynamic> json) {
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
  List<dynamic>? dateOfBirth;
  List<dynamic>? subCounty;
  List<dynamic>? firstName;
  List<dynamic>? gender;
  List<dynamic>? lastName;
  List<dynamic>? bloodGroup;
  List<dynamic>? countyOfResidence;
  List<dynamic>? middleName;
  List<dynamic>? email;

  Errors(
      {this.dateOfBirth,
      this.subCounty,
      this.firstName,
      this.gender,
      this.lastName,
      this.bloodGroup,
      this.countyOfResidence,
      this.middleName,
      this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['date_of_birth'];
    subCounty = json['sub_county'];
    firstName = json['first_name'];
    gender = json['gender'];
    lastName = json['last_name'];
    bloodGroup = json['blood_group'];
    countyOfResidence = json['county_of_residence'];
    middleName = json['middle_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_of_birth'] = dateOfBirth;
    data['sub_county'] = subCounty;
    data['first_name'] = firstName;
    data['gender'] = gender;
    data['last_name'] = lastName;
    data['blood_group'] = bloodGroup;
    data['county_of_residence'] = countyOfResidence;
    return data;
  }
}
