import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/Add%20premises/AddChanel.dart';
import 'package:smart_home/Add%20premises/SelectedPremises.dart';
import 'package:smart_home/Bottom/Bottom.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/DeviceModel.dart';
import 'package:smart_home/Models/PackageModel.dart';
import 'package:smart_home/Models/PremisesDeviceModel.dart';
import 'package:smart_home/Models/PremisesGet.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../MyColors.dart';


class AddDevices extends StatefulWidget {
  final String UPID;
  final String premisesName;
  final String uID;

  const AddDevices({Key key, this.UPID, this.premisesName, this.uID})
      : super(key: key);

  @override
  _AddDevicesState createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  String UPID;
  String premisesName;
  PremisesDevice premisesDevices;
  List<Device> devices = [];
  List<Package> packages = [];
  bool isLoad = true;
  List<int> devicesID = [];
  List<Map<String, dynamic>> packagesID = [];
  List packages_id = [];
  SharedPreferences sharedPreferences;
  String uID;

  @override
  void initState() {
    super.initState();
    UPID = widget.UPID;
    premisesName = widget.premisesName;
    uID = widget.uID;
    start();
    premisesDevices = new PremisesDevice(device: devices, package: packages);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: isLoad
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 60, left: 15, right: 15),
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
                                            premisesName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        )),
                                    Flexible(
                                        flex: 1,
                                        fit: FlexFit.tight,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Next room",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 9,
                          fit: FlexFit.tight,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                    height: 8,
                                  );
                                },
                                itemCount: premisesDevices.device.length +
                                    premisesDevices.package.length,
                                itemBuilder: (_, i) {
                                  return i < premisesDevices.device.length
                                      ? getDeviceDesign(
                                          premisesDevices.device[i])
                                      : getChannelDesign(
                                          premisesDevices.package[
                                              premisesDevices.device.length +
                                                  premisesDevices
                                                      .package.length -
                                                  i -
                                                  1],
                                          i);
                                }),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*  Container(
                                height: 50,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.only(left: 8, right: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.mBackColor),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 0.0),
                                  dense: true,
                                  leading: Icon(Icons.device_hub_outlined),
                                  title: Text(
                                    "Connect New Device",
                                    textScaleFactor: 1.3,
                                  ),
                                  trailing: Icon(
                                    Icons.add_circle,
                                    color: MyColors.mainColor,
                                  ),
                                ),
                              ),*/
                                  Container(
                                      height: 45,
                                      width: 150,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            print(devicesID);
                                            if (devicesID.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Please Select Devices")));
                                            } else {
                                              insertUserDevices();
                                            }
                                          },
                                          child: Text("Done"))),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ));
  }

  Widget getDeviceDesign(Device device) {
    return GestureDetector(
      onTap: () {},
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        dense: true,
        leading: Image.network(
          Environment.imageUrl + device.device.devices_image,
          height: 25,
          width: 25,
        ),
        title: Text(
          device.device.devices_name,
          textScaleFactor: 1.3,
        ),
        trailing: Switch(
          value: devicesID.contains(device.device.devices_id),
          onChanged: (bool isOn) {
            setState(() {
              if (isOn) {
                devicesID.add(device.device.devices_id);
              } else {
                devicesID.remove(device.device.devices_id);
              }
            });
          },
          activeColor: MyColors.green,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.white,
        ),
      ),
    );
  }

  Widget getChannelDesign(Package package, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddChanel(
                      packageID: package.package_id.toString(),
                      packageName: package.package_name,
                      UPID: UPID,
                      uID: uID,
                    ))).then((value) {
          List device_id = value;
          setState(() {
            for (int i = 0; i < packagesID.length; i++) {
              if (packagesID[i]['package_id'] == package.package_id)
                packagesID.removeAt(i);
            }
            if (device_id.length > 0)
              packagesID
                  .add({"package_id": package.package_id, "device_id": value});
          });
        });
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        dense: true,
        leading: Image.network(
          Environment.imageUrl + package.package_icon,
          height: 25,
          width: 25,
        ),
        title: Text(
          package.package_name,
          textScaleFactor: 1.3,
        ),
        trailing: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddChanel(
                            packageID: package.package_id.toString(),
                            packageName: package.package_name,
                          ))).then((value) {
                List device_id = value;
                setState(() {
                  for (int i = 0; i < packagesID.length; i++) {
                    if (packagesID[i]['package_id'] == package.package_id)
                      packagesID.removeAt(i);
                  }
                  if (device_id.length > 0)
                    packagesID.add(
                        {"package_id": package.package_id, "device_id": value});
                });
              });
            },
            icon: Icon(Icons.arrow_forward_ios)),
      ),
    );
  }

  Future<PremisesDevice> fetchPreDevices() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = uID;
    map["up_id"] = UPID;
    PremisesDevice result = await APIService().fetchDevices(map);
    setState(() {
      premisesDevices =
          new PremisesDevice(device: result.device, package: result.package);
      for (int i = 0; i < result.device.length; i++) {
        if (result.device[i].status == 'Added')
          devicesID.add(result.device[i].device.devices_id);
      }
      isLoad = false;
    });
  }

  Future<ResponseModel> insertUserDevices() async {
    setState(() {
      packages_id = [];
    });
    for (int i = 0; i < packagesID.length; i++) {
      print(packagesID[i].runtimeType);
      setState(() {
        packages_id.add("'" +
            '{"package_id":' +
            packagesID[i]['package_id'].toString() +
            ', "device_id":' +
            packagesID[i]['device_id'].toString() +
            "}'");
      });
    }
    Map<String, dynamic> map = Map();
    map["user_id"] = uID;
    map["up_id"] = UPID;
    map["device_id"] = devicesID.toString();
    map["package_id"] = packages_id.toString();

    print("map");
    print(map);

    var result = await APIService().insertUserDevices(map);

    if (result.message == "success") {
      showAlertDialog();
      /*  ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));*/
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  void showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Devices Added'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }


  Future<void> getSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> start() async {
    await getSp();
    fetchPreDevices();
  }
}
