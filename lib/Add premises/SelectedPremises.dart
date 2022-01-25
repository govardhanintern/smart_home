import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremisesOneOne.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/FetchUserPre.dart';
import 'package:smart_home/Models/PremisesGet.dart';
import 'package:smart_home/MyColors.dart';
import 'package:smart_home/main.dart';
import 'AddDevices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectedPremises extends StatefulWidget {
  final List<int> SelectedRoom;

  const SelectedPremises({Key key, this.SelectedRoom}) : super(key: key);

  @override
  _SelectedPremisesState createState() => _SelectedPremisesState();
}

class _SelectedPremisesState extends State<SelectedPremises> {
  List<int> SelectedRoom;
  List<UserPremisesData> userPreList = List();
  bool isLoad = true;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    SelectedRoom = widget.SelectedRoom;
    SelectedRoom.sort();
    start();
  }

  String tName(int index) {
    return userPreList[index].userPremises.premisesName;
  }

  String tIcon(int index) {
    return userPreList[index].premises.eImage.toString();
  }

  String tID(int index) {
    return userPreList[index].userPremises.upId.toString();
  }

  String pCount(int index) {
    return userPreList[index].deviceCount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 60, left: 15, right: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MyColors.mainColor),
                          height: 180,
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
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.drag_handle_outlined,
                                            color: MyColors.white,
                                          )),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          child: Image.asset(
                                            "assets/demo.png",
                                            height: 30,
                                            width: 30,
                                          ),
                                          onTap: () {},
                                        ),
                                      ))
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Welcome Admin!",
                                  style: TextStyle(
                                      color: MyColors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Three premises added",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: MyColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 600,
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: SelectedRoom.length,
                              itemBuilder: (_, i) => boxDesign(
                                  tIcon(SelectedRoom.elementAt(i)),
                                  tName(SelectedRoom.elementAt(i)),
                                  tID(SelectedRoom.elementAt(i)),
                                  pCount(SelectedRoom.elementAt(i)))),
                        ),
                      ],
                    ),
                  ),
                ]),
              ));
  }

  Widget boxDesign(String img, String title, String UPID, String count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Image.network(
              Environment.imageUrl + img,
              height: 50,
              width: 50,
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  count == "0"
                      ? "No devices selected"
                      : "$count devices selected",
                  style: TextStyle(
                      color: count == "0" ? MyColors.orng : MyColors.mainColor),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDevices(
                                  UPID: UPID,
                                  premisesName: title,
                                ))).then((value) {
                                  fetchUserPre();
                    });
                  },
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.add_circle, color: MyColors.mainColor),
                    ),
                  ),
                ),
                Text(
                  "Add Devices",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<List<FetchUserPre>> fetchUserPre() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = sharedPreferences.getString("UserId");

    var result = await APIService().fetchUserPremises(map);
    setState(() {
      userPreList = result.data;
      isLoad = false;
    });
  }

  Future<void> getSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> start() async {
    await getSp();
    fetchUserPre();
  }
}
