import 'dart:convert';

/*
ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());
*/

class ResponseModel {
  String message;
  String user_name;
  int userId;

  ResponseModel({
    this.message,
    this.user_name,
    this.userId,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        message: json["message"],
        user_name: json["user_name"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_name": user_name,
        "userId": userId,
      };
}
