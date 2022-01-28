import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Bottom/UserChannel.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Main%20Page/MainPageAC.dart';
import 'package:smart_home/Main%20Page/MainPageFan.dart';
import 'package:smart_home/Main%20Page/MainPageLamp.dart';
import 'package:smart_home/Main%20Page/MainPageTV.dart';
import 'package:smart_home/Models/DeviceModel.dart';
import 'package:smart_home/Models/FetchTabsData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/Models/PackageModel.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import '../MyColors.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _tabController;

  //List<String> testTab = ["Living Room", "Bed Room", "Kitchen", "Office"];
  SharedPreferences sharedPreferences;

  List<TabsData> tabsList = [];
  bool isLoad = true;
  List<int> devicesID = [];

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 2.0),
                          insets: EdgeInsets.symmetric(horizontal: 30.0)),
                      isScrollable: true,
                      unselectedLabelColor: Colors.grey,
                      labelColor: MyColors.secondColor,
                      indicatorColor: MyColors.secondColor,
                      tabs: List<Widget>.generate(tabsList.length, (int index) {
                        return new Tab(
                            text: tabsList[index].userPremises.premisesName);
                      }),
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    Flexible(
                      flex: 3,
                      fit: FlexFit.tight,
                      child: TabBarView(
                        children:
                            List<Widget>.generate(tabsList.length, (int index) {
                          return SizedBox(
                              height: 400,
                              child: deviceGride(
                                tabsList[index].device,
                                tabsList[index].package,
                                tabsList[index].userPremises.upId.toString(),
                              ));
                        }),
                        controller: _tabController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget deviceGride(List<Device> device, List<Package> package, String UpId) {
    final orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
        itemCount: device.length + package.length,
        itemBuilder: (BuildContext ctx, index) {
          return index < device.length
              ? tabsDeviceDesign(device[index].device, UpId)
              : package.isEmpty
                  ? tabsDeviceDesign(device[index].device, UpId)
                  : tabsPackageDesign(
                      package[device.length + package.length - index - 1],
                      UpId);
        });
  }

  Widget tabsDeviceDesign(DeviceDetails device, String UPID) {
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
                Environment.imageUrl + device.devices_image,
                width: 50,
                height: 50,
                color: devicesID.contains(device.devices_id)
                    ? MyColors.mainColor
                    : Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      device.devices_name,
                      style: TextStyle(
                        color: devicesID.contains(device.devices_id)
                            ? MyColors.mainColor
                            : Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        right: 5,
        child: Switch(
          value: devicesID.contains(device.devices_id),
          onChanged: (bool isOn) {
            setState(() {
              if (isOn) {
                devicesID.add(device.devices_id);
                updateUserDeviceStatus(device.devices_id, UPID);
              } else {
                devicesID.remove(device.devices_id);
                updateUserDeviceStatus(device.devices_id, UPID);
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

  Widget tabsPackageDesign(Package package, String UPID) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserChannel(
                      packageName: package.package_name,
                      packageID: package.package_id.toString(),
                      UpId: UPID,
                    )));
      },
      child: Container(
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
                Environment.imageUrl + package.package_icon,
                width: 50,
                height: 50,
                /*  color: devicesID.contains(device.devices_id)
                      ? MyColors.mainColor
                      : Colors.grey,*/
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      package.package_name,
                      style: TextStyle(
                          /* color: devicesID.contains(device.devices_id)
                              ? MyColors.mainColor
                              : Colors.grey,*/
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<ResponseModel> updateUserDeviceStatus(
      int deviceId, String upid) async {
    Map<String, dynamic> map = Map();
    map["user_id"] = sharedPreferences.getString("UserId");
    map["up_id"] = upid;
    map["device_id"] = deviceId.toString();

    print(map);

    ResponseModel result = await APIService().updateUserDeviceStatus(map);
    if (result.message == "success") {
      /*ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));*/
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }

  Future<FetchTabsData> tabsPremisesbyUser() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = sharedPreferences.getString("UserId");

    FetchTabsData result = await APIService().tabsPremisesbyUser(map);

    setState(() {
      tabsList = result.data;
      _tabController = new TabController(length: tabsList.length, vsync: this);
      for (int i = 0; i < tabsList[i].device.length; i++) {
        if (tabsList[i].device[i].status == 'ON')
          devicesID.add(tabsList[i].device[i].device.devices_id);
      }
      isLoad = false;
    });
  }

  Future<void> getSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> start() async {
    await getSp();
    tabsPremisesbyUser();
  }
}

