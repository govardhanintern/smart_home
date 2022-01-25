import 'dart:convert';

import 'package:smart_home/Models/PackageModel.dart';

import 'DeviceModel.dart';

class FetchTabsData {
  FetchTabsData({
    this.data,
    this.message,
  });

  List<TabsData> data;
  String message;

  factory FetchTabsData.fromJson(Map<String, dynamic> json) => FetchTabsData(
        data:
            List<TabsData>.from(json["data"].map((x) => TabsData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class TabsData {
  TabsData({
    this.userPremises,
    this.device,
    this.package,
  });

  UserPremises userPremises;
  List<Device> device;
  List<Package> package;

  TabsData.fromJson(Map<String, dynamic> json) {
    userPremises = UserPremises.fromJson(json["user_premises"]);
    device = [];
    if (json["device"] != null) {
      json["device"].forEach((v) {
        device.add(Device.fromJson(v));
      });
    }
    package = [];
    if (json["package"] != null) {
      json["package"].forEach((v) {
        package.add(Package.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["device"] = [];
    if (device != null) {
      map["device"] = device.map((v) => v.toJson()).toList();
    }
    map["package"] = [];
    if (package != null) {
      map["package"] = package.map((v) => v.toJson()).toList();
    }
    map["user_premises"] = userPremises.toJson();
    return map;
  }
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


