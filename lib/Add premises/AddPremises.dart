import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/FetchUserPre.dart';
import 'package:smart_home/MyColors.dart';
import 'package:smart_home/Registration/Login.dart';
import 'package:smart_home/Registration/RegisteredUser.dart';
import 'AddPremisesOneOne.dart';
import 'SelectedPremises.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform, exit;

class AddPremises extends StatefulWidget {
  final String uID;

  const AddPremises({Key key, this.uID}) : super(key: key);

  @override
  _AddPremisesState createState() => _AddPremisesState();
}

class _AddPremisesState extends State<AddPremises> {
  List<String> itemName = [];
  List<String> itemImage = [];
  List<int> tapped = [];
  bool _isVisible = false;
  List<int> SelectedRoom = [];
  SharedPreferences sharedPreferences;
  String uID = "";

  List<UserPremisesData> userPreList = List();
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    uID = widget.uID;
    start();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
        onWillPop: () async {
          // Do something here
          print("After clicking the Android Back Button");
          closeAlertDialog();
          return false;
        },
        child: Scaffold(
            body: Stack(children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 40, left: 15, right: 15),
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
                                    child: Image.asset(
                                      "assets/demo.png",
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            showAlertDialog();
                                          },
                                          icon: Icon(
                                            Icons.logout,
                                            color: MyColors.white,
                                          )),
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
                                "Start adding premises which you would like to manage",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: MyColors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisteredUser()));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: MyColors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "Manage Users",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: MyColors.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      userPreList.isEmpty
                          ? Text("")
                          : isLoad
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Container(
                                  padding: EdgeInsets.all(8),
                                  height: 600,
                                  child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 8,
                                              crossAxisCount: (orientation ==
                                                      Orientation.portrait)
                                                  ? 2
                                                  : 2),
                                      itemCount: userPreList.length,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (tapped.contains(index)) {
                                              setState(() {
                                                tapped.remove(index);
                                                SelectedRoom.remove(index);
                                                if (tapped.length == 0) {
                                                  _isVisible = false;
                                                }
                                                print("tapped Remove");
                                              });
                                            } else {
                                              setState(() {
                                                tapped.add(index);
                                                SelectedRoom.add(index);
                                                _isVisible = true;
                                                print("tapped Add");
                                              });
                                            }
                                            print("Selected Rom $SelectedRoom");
                                          },
                                          child: boxDesign(
                                              userPreList[index]
                                                  .premises
                                                  .eImage,
                                              userPreList[index]
                                                  .userPremises
                                                  .premisesName,
                                              index),
                                        );
                                      }),
                                ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 20,
                child: Visibility(
                  visible: _isVisible,
                  child: Container(
                      height: 45,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          // print(SelectedRoom.toString());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectedPremises(
                                        SelectedRoom: SelectedRoom,
                                        uID: uID,
                                      )));
                        },
                        child: Text("Done"),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      )),
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPremisesOneOne(
                              uID: uID,
                            ))).then((value) {
                  fetchUserPre();
                });
                // Navigator.pop(context);
              },
              label: Text('Add Premises'),
              icon: Icon(Icons.add_circle),
              backgroundColor: MyColors.mainColor,
            )));
  }

  Widget boxDesign(String img, String title, int val) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      height: 114,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
            color: tapped.contains(val) ? MyColors.mainColor : MyColors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              Environment.imageUrl + img,
              height: 50,
              width: 50,
            ),
            Text(title),
          ],
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.check_circle,
              color: tapped.contains(val) ? MyColors.mainColor : Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }

  void showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure you want to Logout'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'NO'),
            child: Text('NO'),
          ),
          TextButton(
            onPressed: () => logout(),
            child: Text('YES'),
          ),
        ],
      ),
    );
  }

  void closeAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure want close this application'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              bool plat = Platform.isAndroid;
              if (plat) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
            child: Text('YES'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO'),
          ),
        ],
      ),
    );
  }

  void logout() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  Future<List<FetchUserPre>> fetchUserPre() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = uID;

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
    print(sharedPreferences.getString("UserId"));
  }
}
