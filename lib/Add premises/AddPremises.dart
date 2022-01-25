import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/FetchUserPre.dart';
import 'package:smart_home/MyColors.dart';
import 'AddPremisesOneOne.dart';
import 'SelectedPremises.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPremises extends StatefulWidget {
  const AddPremises({Key key}) : super(key: key);

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

  List<UserPremisesData> userPreList = List();
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 60, left: 15, right: 15),
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
                                  child: Image.asset(
                                    "assets/demo.png",
                                    height: 30,
                                    width: 30,
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
                            "Start adding premises which you would like to manage",
                            style: TextStyle(
                              fontSize: 12,
                              color: MyColors.white,
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
                                          userPreList[index].premises.eImage,
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
                                  )));
                    },
                    child: Text("Done"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    builder: (context) => AddPremisesOneOne())).then((value) {
              fetchUserPre();
            });
            // Navigator.pop(context);
          },
          label: Text('Add Premises'),
          icon: Icon(Icons.add_circle),
          backgroundColor: MyColors.mainColor,
        ));
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
    print(sharedPreferences.getString("UserId"));
  }
}
