import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/SelectedPremises.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/DeviceModel.dart';
import 'package:smart_home/Models/PremisesDeviceModel.dart';
import 'package:smart_home/Models/PremisesDeviceModel.dart';
import 'package:smart_home/Models/PremisesDeviceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MyColors.dart';

class AddChanel extends StatefulWidget {
  final String packageID;
  final String packageName;
  final String UPID;
  final String uID;

  const AddChanel(
      {Key key, this.packageID, this.packageName, this.UPID, this.uID})
      : super(key: key);

  @override
  _AddChanelState createState() => _AddChanelState();
}

class _AddChanelState extends State<AddChanel> {
  String packageID;
  String packageName;
  String UPID;
  String uID;
  List<Device> devices = [];
  bool isLoad = true;
  List<int> devicesID = [];
  SharedPreferences sharedPreferences;
  List<Map<String, dynamic>> packagesID = [];

  @override
  void initState() {
    super.initState();
    packageID = widget.packageID;
    packageName = widget.packageName;
    UPID = widget.UPID;
    uID = widget.uID;
    start();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 60, left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.mainColor),
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: MyColors.white,
                                      )),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      packageName,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  )),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        print(devicesID);
                                        Navigator.pop(context, devicesID);
                                      },
                                      child: Text(
                                        "Save",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 600,
                      padding: EdgeInsets.all(10),
                      child: devices.isEmpty
                          ? Center(child: Text("No Devices"))
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                      crossAxisCount:
                                          (orientation == Orientation.portrait)
                                              ? 2
                                              : 2),
                              itemCount: devices.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return boxDesign(devices[index],
                                    devices[index].device.devices_id);
                              }),
                    ),
                  ],
                ),
              ));
  }

  Widget boxDesign(Device device, int index) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: 10),
        height: 136,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(
                Environment.imageUrl + device.device.devices_image,
                width: 50,
                height: 50,
                color: devicesID.contains(index)
                    ? MyColors.mainColor
                    : Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              device.device.devices_name,
              style: TextStyle(
                color: devicesID.contains(index)
                    ? MyColors.mainColor
                    : Colors.grey,
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      Positioned(
        right: 5,
        child: Switch(
          value: devicesID.contains(index),
          onChanged: (bool isOn) {
            setState(() {
              if (isOn) {
                devicesID.add(index);
              } else {
                devicesID.remove(index);
              }
            });
          },
          activeColor: MyColors.green,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.white,
        ),
      ),
    ]);
  }

  Future<void> fetchPackageDevices() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = uID;
    map["up_id"] = UPID;
    map["package_id"] = packageID;
    PremisesDevice result = await APIService().fetchPackageDevices(map);
    setState(() {
      devices = result.device;
      for (int i = 0; i < result.device.length; i++) {
        if (result.device[i].status == 'Added')
          devicesID.add(result.device[i].device.devices_id);
      }
      isLoad = false;
    });
    print(devices.length);
  }

  Future<void> getSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> start() async {
    await getSp();
    fetchPackageDevices();
  }
}
