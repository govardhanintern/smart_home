import 'dart:convert';

import 'package:smart_home/Models/DeviceModel.dart';
import 'package:smart_home/Models/FetchTabsData.dart';
import 'package:smart_home/Models/FetchUserDetails.dart';
import 'package:smart_home/Models/FetchUserList.dart';
import 'package:smart_home/Models/FetchUserPre.dart';
import 'package:smart_home/Models/PIconModel.dart';
import 'package:smart_home/Models/PackageModel.dart';
import 'package:smart_home/Models/PremisesDeviceModel.dart';
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

  Future<PIconModel> fetchPremises() async {
    String url = APIConstant.fetchPremises;
    print(Uri.parse(url).path);
    var result = await http.get(Uri.parse(url));
    print(result.body);

    var data = jsonDecode(result.body);
    PIconModel model = PIconModel.fromJson(data);
    print(result.body);
    return model;
  }

  Future<ResponseModel> insertUserPremises(Map<String, dynamic> map) async {
    String url = APIConstant.insertUserPremises;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<ResponseModel> insertUserDevices(Map<String, dynamic> map) async {
    String url = APIConstant.insertUserDevices;
    var result = await http.post(Uri.parse(url), body: map);

    print(result.body);
    var Data = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<FetchUserPre> fetchUserPremises(Map<String, dynamic> map) async {
    String url = APIConstant.fetchUserPremises;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    FetchUserPre model = FetchUserPre.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<PremisesDevice> fetchDevices(Map<String, dynamic> map) async {
    String url = APIConstant.fetchDevices;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    PremisesDevice model = PremisesDevice.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<PremisesDevice> fetchPackageDevices(Map<String, dynamic> map) async {
    String url = APIConstant.fetchPackageDevices;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    PremisesDevice model = PremisesDevice.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<PremisesDevice> fetchPremisesDevice(Map<String, dynamic> map) async {
    String url = APIConstant.fetchPremisesDevice;
    var result = await http.post(Uri.parse(url), body: map);

    var Data = jsonDecode(result.body);
    PremisesDevice model = PremisesDevice.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<FetchTabsData> tabsPremisesbyUser(Map<String, dynamic> map) async {
    String url = APIConstant.fetchPremisesbyUserId;
    var result = await http.post(Uri.parse(url), body: map);
    print(result.body);
    var Data = jsonDecode(result.body);
    FetchTabsData model = FetchTabsData.fromJson(Data);
    return model;
  }

  Future<ResponseModel> updateUserDeviceStatus(Map<String, dynamic> map) async {
    String url = APIConstant.updateUserDeviceStatus;
    var result = await http.post(Uri.parse(url), body: map);

    print(result.body);
    var Data = jsonDecode(result.body);
    ResponseModel model = ResponseModel.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<FetchUserList> fetchAllUsers() async {
    String url = APIConstant.fetchAllUsers;
    var result = await http.get(Uri.parse(url));

    print(result.body);
    var Data = jsonDecode(result.body);
    FetchUserList model = FetchUserList.fromJson(Data);
    print(result.body);
    return model;
  }

  Future<FetchUserDetails> fetchUserDetails(Map<String, dynamic> map) async {
    String url = APIConstant.fetchUserDetails;
    var result = await http.post(Uri.parse(url), body: map);

    print(result.body);
    var Data = jsonDecode(result.body);
    FetchUserDetails model = FetchUserDetails.fromJson(Data);
    print(result.body);
    return model;
  }
}
