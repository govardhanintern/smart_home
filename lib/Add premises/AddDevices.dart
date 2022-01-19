import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddChanel.dart';
import 'package:smart_home/Add%20premises/Premises.dart';
import 'package:smart_home/Bottom/Bottom.dart';
import 'package:smart_home/Models/PremisesGet.dart';

import '../MyColors.dart';

class AddDevices extends StatefulWidget {
  final List<int> SelectedRoom;

  const AddDevices({Key key, this.SelectedRoom}) : super(key: key);

  @override
  _AddDevicesState createState() => _AddDevicesState();
}

class _AddDevicesState extends State<AddDevices> {
  List<int> SelectedRoom;

  @override
  void initState() {
    super.initState();
    SelectedRoom = widget.SelectedRoom;
    SelectedRoom.sort();
  }

  bool lamp = false;
  bool fan = false;
  bool ac = false;
  bool tv = false;
  bool music = false;

  onChangeLamp(bool newvalue1) {
    setState(() {
      lamp = newvalue1;
    });
  }

  onChangeFan(bool newvalue2) {
    setState(() {
      fan = newvalue2;
    });
  }

  onChangeAc(bool newvalue3) {
    setState(() {
      ac = newvalue3;
    });
  }

  onChangeTv(bool newvalue4) {
    setState(() {
      tv = newvalue4;
    });
  }

  onChangeMusic(bool newvalue5) {
    setState(() {
      music = newvalue5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
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
                            "Living Room",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        )),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Next room",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                /*boxDesign("assets/lamp.png", "Lamp", lamp, onChangeLamp),
                SizedBox(
                  height: 20,
                ),
                boxDesign("assets/fan.png", "Fan", fan, onChangeFan),
                SizedBox(
                  height: 20,
                ),*/

                boxDesign("assets/ac.png", "AC", ac, onChangeAc),
                SizedBox(
                  height: 20,
                ),
                boxDesign("assets/tv.png", "TV", tv, onChangeTv),
                SizedBox(
                  height: 20,
                ),
                boxDesign(
                    "assets/music.png", "Music System", music, onChangeMusic),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddChanel()));
                    },
                    child: chanelBox("assets/chanel.png", "8 Chanel")),
                SizedBox(
                  height: 20,
                ),
                chanelBox("assets/chanel.png", "6 Chanel"),
                SizedBox(
                  height: 20,
                ),
                chanelBox("assets/chanel.png", "4 Chanel"),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.mBackColor),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
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
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 45,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Bottom()));
                        },
                        child: Text("Done"))),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget boxDesign(
      String img, String title, bool val, Function onChangeMethod) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      dense: true,
      leading: Image.asset(
        img,
        height: 25,
        width: 25,
      ),
      title: Text(
        title,
        textScaleFactor: 1.3,
      ),
      trailing: Switch(
        value: val,
        onChanged: (newValue) {
          onChangeMethod(newValue);
        },
        activeColor: MyColors.green,
        inactiveTrackColor: Colors.grey,
        inactiveThumbColor: Colors.white,
      ),
    );
  }

  Widget chanelBox(String img, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      dense: true,
      leading: Image.asset(
        img,
        height: 25,
        width: 25,
      ),
      title: Text(
        title,
        textScaleFactor: 1.3,
      ),
      trailing: IconButton(
          onPressed: () {
            if (title == "8 Chanel") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddChanel()));
            }
          },
          icon: Icon(Icons.arrow_forward_ios)),
    );
  }
}
