// To parse this JSON data, do
//
//     final fetchUserPre = fetchUserPreFromJson(jsonString);

import 'dart:convert';

FetchUserPre fetchUserPreFromJson(String str) =>
    FetchUserPre.fromJson(json.decode(str));

String fetchUserPreToJson(FetchUserPre data) => json.encode(data.toJson());

class FetchUserPre {
  FetchUserPre({
    this.data,
    this.message,
  });

  List<UserPremisesData> data;
  String message;

  factory FetchUserPre.fromJson(Map<String, dynamic> json) => FetchUserPre(
        data: List<UserPremisesData>.from(
            json["data"].map((x) => UserPremisesData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class UserPremisesData {
  UserPremisesData({
    this.premises,
    this.userPremises,
    this.deviceCount,
  });

  Premises premises;
  UserPremises userPremises;
  int deviceCount;

  factory UserPremisesData.fromJson(Map<String, dynamic> json) =>
      UserPremisesData(
        premises: Premises.fromJson(json["premises"]),
        userPremises: UserPremises.fromJson(json["user_premises"]),
        deviceCount: json["device_count"],
      );

  Map<String, dynamic> toJson() => {
        "premises": premises.toJson(),
        "user_premises": userPremises.toJson(),
        "device_count": deviceCount,
      };
}

class Premises {
  Premises({
    this.piId,
    this.dImage,
    this.eImage,
  });

  int piId;
  String dImage;
  String eImage;

  factory Premises.fromJson(Map<String, dynamic> json) => Premises(
        piId: json["pi_id"],
        dImage: json["d_image"],
        eImage: json["e_image"],
      );

  Map<String, dynamic> toJson() => {
        "pi_id": piId,
        "d_image": dImage,
        "e_image": eImage,
      };
}

class UserPremises {
  UserPremises({
    this.upId,
    this.premisesName,
    this.user,
    this.pi,
  });

  int upId;
  String premisesName;
  int user;
  int pi;

  factory UserPremises.fromJson(Map<String, dynamic> json) => UserPremises(
        upId: json["up_id"],
        premisesName: json["premises_name"],
        user: json["user"],
        pi: json["pi"],
      );

  Map<String, dynamic> toJson() => {
        "up_id": upId,
        "premises_name": premisesName,
        "user": user,
        "pi": pi,
      };
}
