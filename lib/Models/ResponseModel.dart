import 'dart:convert';

ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.message,
    this.userId,
  });

  String message;
  int userId;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        message: json["message"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
      };
}
