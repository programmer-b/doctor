class MLJWTDecoder {
  String? iss;
  String? aud;
  int? iat;
  int? nbf;
  Usr? usr;
  int? exp;
  String? jti;

  MLJWTDecoder(
      {this.iss, this.aud, this.iat, this.nbf, this.usr, this.exp, this.jti});

  MLJWTDecoder.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    aud = json['aud'];
    iat = json['iat'];
    nbf = json['nbf'];
    usr = json['usr'] != null ? new Usr.fromJson(json['usr']) : null;
    exp = json['exp'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iss'] = this.iss;
    data['aud'] = this.aud;
    data['iat'] = this.iat;
    data['nbf'] = this.nbf;
    if (this.usr != null) {
      data['usr'] = this.usr!.toJson();
    }
    data['exp'] = this.exp;
    data['jti'] = this.jti;
    return data;
  }
}

class Usr {
  int? userId;
  String? username;
  dynamic mobileVerified;
  dynamic profileVerified;
  dynamic profile;

  Usr(
      {this.userId,
      this.username,
      this.mobileVerified,
      this.profileVerified,
      this.profile});

  Usr.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    mobileVerified = json['mobile_verified'];
    profileVerified = json['profile_verified'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['mobile_verified'] = this.mobileVerified;
    data['profile_verified'] = this.profileVerified;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class Profile {
  String? firstName;
  String? middleName;
  String? lastName;
  dynamic email;
  String? dateOfBirth;
  String? gender;
  String? bloodGroup;
  String? countyOfResidence;
  dynamic address;
  int? id;

  Profile(
      {this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.bloodGroup,
      this.countyOfResidence,
      this.address,
      this.id});

  Profile.fromJson(dynamic json) {
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    countyOfResidence = json['county_of_residence'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['blood_group'] = this.bloodGroup;
    data['county_of_residence'] = this.countyOfResidence;
    data['address'] = this.address;
    data['id'] = this.id;
    return data;
  }
}
