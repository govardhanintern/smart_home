// To parse this JSON data, do
//
//     final pIconModel = pIconModelFromJson(jsonString);

import 'dart:convert';

PIconModel pIconModelFromJson(String str) => PIconModel.fromJson(json.decode(str));

String pIconModelToJson(PIconModel data) => json.encode(data.toJson());

class PIconModel {
  PIconModel({
    this.data,
  });

  List<PIconData> data;

  factory PIconModel.fromJson(Map<String, dynamic> json) => PIconModel(
    data: List<PIconData>.from(json["data"].map((x) => PIconData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PIconData {
  PIconData({
    this.piId,
    this.dImage,
    this.eImage,
  });

  int piId;
  String dImage;
  String eImage;

  factory PIconData.fromJson(Map<String, dynamic> json) => PIconData(
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
