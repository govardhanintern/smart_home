import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/Premises.dart';

import '../MyColors.dart';

class AddChanel extends StatefulWidget {
  const AddChanel({Key key}) : super(key: key);

  @override
  _AddChanelState createState() => _AddChanelState();
}

class _AddChanelState extends State<AddChanel> {
  List<bool> isInstructionView = [false, false, false, false];
  List<String> itemName = [
    "Main Light",
    "Light",
    "Light",
    "Light",
    "Light",
    "FAN"
  ];
  List<String> itemImage = [
    "assets/lamp.png",
    "assets/lamp.png",
    "assets/lamp.png",
    "assets/lamp.png",
    "assets/lamp.png",
    "assets/fan.png",
  ];

  @override
  void initState() {
    super.initState();
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(false);
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
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
            height: 600,
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount:
                        (orientation == Orientation.portrait) ? 2 : 2),
                itemCount: itemName.length,
                itemBuilder: (BuildContext ctx, index) {
                  return boxDesign(itemImage[index], itemName[index], index);
                }),
          ),
        ],
      ),
    ));
  }

  Widget boxDesign(String img, String title, int index) {
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
              child: Image.asset(
                img,
                width: 50,
                height: 50,
                color:
                    isInstructionView[index] ? MyColors.mainColor : Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color:
                    isInstructionView[index] ? MyColors.mainColor : Colors.grey,
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
          value: isInstructionView[index],
          onChanged: (bool isOn) {
            setState(() {
              isInstructionView[index] = isOn;
            });
          },
          activeColor: MyColors.green,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.white,
        ),
      ),
    ]);
  }
}
