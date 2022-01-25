import 'dart:convert';
class Device {
  DeviceDetails device;
  String status;

  Device({
    this.device,
    this.status,
  });

  Device.fromJson(Map<String, dynamic> json) {
    device = DeviceDetails.fromJson(json["device"]);
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["device"] = device.toJson();
    map["status"] = status;
    return map;
  }
}
class DeviceDetails {
  int devices_id;
  String devices_name;
  String devices_image;
  String devices_type;

  DeviceDetails({
    this.devices_id,
    this.devices_name,
    this.devices_image,
    this.devices_type,
  });

  DeviceDetails.fromJson(Map<String, dynamic> json) {
    devices_id = json["devices_id"];
    devices_name = json["devices_name"];
    devices_image = json["devices_image"];
    devices_type = json["devices_type"];
  }

  Map<String, dynamic> toJson()  {
    final Map<String, dynamic> map = new Map<String, dynamic>();
      map["devices_id"] = devices_id;
      map["devices_name"] = devices_name;
      map["devices_image"] = devices_image;
      map["devices_type"] = devices_type;
      return map;
  }
}
