import 'dart:convert';

class FetchUserDetails {
  FetchUserDetails({
    this.user,
    this.userDetail,
    this.message,
  });

  User user;
  UserDetail userDetail;
  String message;

  factory FetchUserDetails.fromJson(Map<String, dynamic> json) =>
      FetchUserDetails(
        user: User.fromJson(json["user"]),
        userDetail: UserDetail.fromJson(json["user_detail"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "user_detail": userDetail.toJson(),
        "message": message,
      };
}

class User {
  User({
    this.userId,
    this.userMobile,
    this.userPassword,
    this.userStatus,
  });

  int userId;
  String userMobile;
  String userPassword;
  String userStatus;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        userMobile: json["user_mobile"],
        userPassword: json["user_password"],
        userStatus: json["user_status"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_mobile": userMobile,
        "user_password": userPassword,
        "user_status": userStatus,
      };
}

class UserDetail {
  UserDetail({
    this.udId,
    this.udName,
    this.udEmail,
    this.udAddress,
    this.udPincode,
    this.state,
    this.city,
    this.ssId,
    this.wifiPassword,
    this.user,
    this.unique,
  });

  int udId;
  String udName;
  String udEmail;
  String udAddress;
  int udPincode;
  String state;
  String city;
  String ssId;
  String wifiPassword;
  int user;
  int unique;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        udId: json["ud_id"],
        udName: json["ud_name"],
        udEmail: json["ud_email"],
        udAddress: json["ud_address"],
        udPincode: json["ud_pincode"],
        state: json["state"],
        city: json["city"],
        ssId: json["ss_id"],
        wifiPassword: json["wifi_password"],
        user: json["user"],
        unique: json["unique"],
      );

  Map<String, dynamic> toJson() => {
        "ud_id": udId,
        "ud_name": udName,
        "ud_email": udEmail,
        "ud_address": udAddress,
        "ud_pincode": udPincode,
        "state": state,
        "city": city,
        "ss_id": ssId,
        "wifi_password": wifiPassword,
        "user": user,
        "unique": unique,
      };
}
