import 'dart:convert';

import 'package:smart_home/Models/ResponseModel.dart';

import 'APIConstant.dart';

import 'package:http/http.dart' as http;

class APIService {
  Future<ResponseModel> signUp(Map<String, dynamic> map) async {
    String url = APIConstant.signUp;
    print(Uri.parse(url).path);
    var result = await http.post(Uri.parse(url), body: map);
    print(result.body);

    var Address = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Address);
    print(result.body);
    return model;
  }

  Future<ResponseModel> login(Map<String, dynamic> map) async {
    String url = APIConstant.login;
    print(Uri.parse(url).path);
    var result = await http.post(Uri.parse(url), body: map);
    print(result.body);

    var Address = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Address);
    print(result.body);
    return model;
  }

  Future<ResponseModel> verifyMobile(Map<String, dynamic> map) async {
    String url = APIConstant.verifyMobile;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Data);
    print(result.body);
    return model;
  }
}
