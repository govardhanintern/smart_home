import 'dart:convert';

import 'package:smart_home/Models/DeviceModel.dart';

class Package {

  int package_id;
  String package_name;
  String package_icon;
  List<Device> package_device;

  Package({
    this.package_id,
    this.package_name,
    this.package_icon,
    this.package_device,
  });

  Package.fromJson(Map<String, dynamic> json) {
    package_id = json["package_id"];
    package_name = json["package_name"];
    package_icon = json["package_icon"];
    package_device = [];
    if (json["package_device"] != null) {
      json["package_device"].forEach((v) {
        package_device.add(Device.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["package_id"] = package_id;
    map["package_name"] = package_name;
    map["package_icon"] = package_icon;
    map["package_device"] = [];
    if (package_device != null) {
      map["package_device"] = package_device.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

