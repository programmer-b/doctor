class DKUserTokenDecodeModel {
  String? iss;
  String? aud;
  int? iat;
  int? nbf;
  Usr? usr;
  int? exp;
  String? jti;

  DKUserTokenDecodeModel(
      {this.iss, this.aud, this.iat, this.nbf, this.usr, this.exp, this.jti});

  DKUserTokenDecodeModel.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    aud = json['aud'];
    iat = json['iat'];
    nbf = json['nbf'];
    usr = json['usr'] != null ? Usr.fromJson(json['usr']) : null;
    exp = json['exp'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iss'] = iss;
    data['aud'] = aud;
    data['iat'] = iat;
    data['nbf'] = nbf;
    if (usr != null) {
      data['usr'] = usr!.toJson();
    }
    data['exp'] = exp;
    data['jti'] = jti;
    return data;
  }
}

class Usr {
  int? id;
  String? username;
  int? mobileVerified;
  int? profileUpdated;
  Profile? profile;

  Usr(
      {this.id,
      this.username,
      this.mobileVerified,
      this.profileUpdated,
      this.profile});

  Usr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobileVerified = json['mobile_verified'];
    profileUpdated = json['profile_updated'];
    profile =
        json['patient profile'] != null ? Profile.fromJson(json['patient profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['mobile_verified'] = mobileVerified;
    data['patient profile'] = profileUpdated;
    if (profile != null) {
      data['patient profile'] = profile!.toJson();
    }
    return data;
  }
}

class Profile {
  int? id;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic bloodGroup;
  dynamic countyOfResidence;
  dynamic subCounty;
  dynamic address;
  int? createdAt;

  Profile(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.email,
      this.dateOfBirth,
      this.gender,
      this.bloodGroup,
      this.countyOfResidence,
      this.subCounty,
      this.address,
      this.createdAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    countyOfResidence = json['county_of_residence'];
    address = json['address'];
    createdAt = json['created_at'];
    subCounty = json['sub_county'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['blood_group'] = bloodGroup;
    data['county_of_residence'] = countyOfResidence;
    data['sub_county'] = subCounty;
    data['address'] = address;
    data['created_at'] = createdAt;
    return data;
  }
}
