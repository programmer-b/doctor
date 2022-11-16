class DKRefreshTokenModel {
  int? userId;
  String? phoneNumber;
  String? token;

  DKRefreshTokenModel({this.userId, this.phoneNumber, this.token});

  DKRefreshTokenModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    phoneNumber = json['phone number'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['phone number'] = phoneNumber;
    data['token'] = token;
    return data;
  }
}