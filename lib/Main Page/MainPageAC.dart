import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Main%20Page/MainPageTV.dart';
import 'package:smart_home/main.dart';

import '../MyColors.dart';

class MainPageAC extends StatefulWidget {
  const MainPageAC({Key key}) : super(key: key);

  @override
  _MainPageACState createState() => _MainPageACState();
}

class _MainPageACState extends State<MainPageAC> {
  bool isInstructionView = false;

  String deviceStatus = "";
  int acVal = 24;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Container(
              padding: EdgeInsets.only(top: 45, left: 15, right: 15),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(
                                "Next room",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => null));
                              },
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: Stack(children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AC",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (acVal > 16) {
                                isInstructionView ? acVal-- : null;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove,
                            color: isInstructionView
                                ? MyColors.mainColor
                                : MyColors.greyColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          acVal.toString() + "c",
                          style: TextStyle(
                              fontSize: 32,
                              color: isInstructionView
                                  ? MyColors.mainColor
                                  : MyColors.greyColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (acVal < 32) {
                                  isInstructionView ? acVal++ : null;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: isInstructionView
                                  ? MyColors.mainColor
                                  : MyColors.greyColor,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/acon.png",
                      height: 127,
                      width: 311,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deviceStatus = "Cooling";
                                  });
                                },
                                child:
                                    boxDesign("assets/cooling.png", "Cooling")),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deviceStatus = "Fan";
                                  });
                                },
                                child: boxDesign("assets/fan.png", "Fan")),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deviceStatus = "Heat";
                                  });
                                },
                                child: boxDesign("assets/heat.png", "Heat")),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    deviceStatus = "Dry";
                                  });
                                },
                                child: boxDesign("assets/dry.png", "Dry")),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Other Devices",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              otherDevices("assets/fan.png", "Fan"),
                              SizedBox(
                                width: 10,
                              ),
                              otherDevices("assets/ac.png", "AC"),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPageTV()));
                                  },
                                  child: otherDevices("assets/tv.png", "TV")),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 15,
                child: Switch(
                  value: isInstructionView,
                  onChanged: (bool isOn) {
                    setState(() {
                      isInstructionView = isOn;
                    });
                  },
                  activeColor: MyColors.green,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ]),
          ),
        ],
      ),
    ));
  }

  Widget otherDevices(String img, String title) {
    return Container(
      height: 48,
      width: 86,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: MyColors.lgrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 20,
            width: 20,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget boxDesign(String img, String title) {
    return Container(
      height: 54,
      width: 145,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isInstructionView
              ? deviceStatus == title
                  ? MyColors.mainColor
                  : MyColors.mBackColor
              : MyColors.lgrey),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            height: 32,
            width: 32,
            color: isInstructionView
                ? deviceStatus == title
                    ? MyColors.white
                    : MyColors.secondColor
                : MyColors.greyColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                color: isInstructionView
                    ? deviceStatus == title
                        ? MyColors.white
                        : MyColors.secondColor
                    : MyColors.greyColor),
          ),
        ],
      ),
    );
  }
}
