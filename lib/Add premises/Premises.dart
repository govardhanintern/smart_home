import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremisesOneOne.dart';
import 'package:smart_home/Models/PremisesGet.dart';

import 'package:smart_home/MyColors.dart';

import 'AddDevices.dart';

class Premises extends StatefulWidget {
  final List<int> SelectedRoom;

  const Premises({Key key, this.SelectedRoom}) : super(key: key);

  @override
  _PremisesState createState() => _PremisesState();
}

class _PremisesState extends State<Premises> {
  List<int> SelectedRoom;

  @override
  void initState() {
    super.initState();
    SelectedRoom = widget.SelectedRoom;
    print(SelectedRoom.toString());
    print(SelectedRoom.length);
    print(PremisesGet.details.length);
    print(tName() + "+++++++++++++++++++++++++++++++");
    print(tIcon() + "+++++++++++++++++++++++++++++++");
  }

  String tName() {
    String nameR = "";
    for (int i = 0; i < SelectedRoom.length; i++) {
      nameR = PremisesGet.details[i].roomName.toString();
    }
    return nameR;
  }

  String tIcon() {
    String iconR = "";
    for (int i = 0; i < SelectedRoom.length; i++) {
      iconR = PremisesGet.details[i].roomImage.toString();
    }
    return iconR;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(children: [
        Container(
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
                        "Welcome John!",
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
                height: 20,
              ),
              /*SizedBox(
                height: 600,
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 20,
                    );
                  },
                  itemCount: SelectedRoom.length,
                  itemBuilder: (_, i) => boxDesign(tIcon(), tName()),
                ),
              ),*/
            ],
          ),
        ),
      ]),
    ));
  }

  Widget boxDesign(String img, String title) {
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
            child: Image.asset(
              img,
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
                  "No devices selected",
                  style: TextStyle(color: MyColors.orng),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddDevices()));
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
}
