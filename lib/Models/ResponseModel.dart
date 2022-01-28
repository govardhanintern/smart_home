import 'dart:convert';

/*
ResponseModel responseModelFromJson(String str) =>
    ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());
*/

class ResponseModel {
  String message;
  String user_status;
  int userId;

  ResponseModel({
    this.message,
    this.user_status,
    this.userId,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        message: json["message"],
        user_status: json["user_status"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_status": user_status,
        "userId": userId,
      };
}
