import 'dart:convert';
import 'package:smart_home/Models/DeviceModel.dart';
import 'PackageModel.dart';

class PremisesDevice {
  List<Device> device;
  List<Package> package;

  PremisesDevice({
    this.device,
    this.package,
  });

  PremisesDevice.fromJson(Map<String, dynamic> json) {
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

    return map;
  }
}
