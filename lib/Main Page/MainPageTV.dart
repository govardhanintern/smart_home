import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Main%20Page/MainPageFan.dart';
import 'package:smart_home/main.dart';

import '../MyColors.dart';

class MainPageTV extends StatefulWidget {
  const MainPageTV({Key key}) : super(key: key);

  @override
  _MainPageTVState createState() => _MainPageTVState();
}

class _MainPageTVState extends State<MainPageTV> {
  bool isInstructionView = false;

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
                      "TV",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      "assets/tvon.png",
                      height: 127,
                      width: 311,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MyColors.white),
                          child: Image.asset(
                            "assets/mute.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MyColors.white),
                          child: Image.asset(
                            "assets/volume_down.png",
                            height: 24,
                            width: 24,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: MyColors.white),
                          child: Image.asset(
                            "assets/volume_up.png",
                            height: 24,
                            width: 24,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            boxDesign("Ch"),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: isInstructionView
                                      ? MyColors.mainColor
                                      : MyColors.lgrey),
                              child: Image.asset(
                                "assets/homevector.png",
                                height: 5,
                                width: 5,
                                color: isInstructionView
                                    ? MyColors.white
                                    : Colors.grey,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            boxDesign("Vol."),
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
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPageFan()));
                                  },
                                  child: otherDevices("assets/fan.png", "Fan")),
                              SizedBox(
                                width: 10,
                              ),
                              otherDevices("assets/ac.png", "AC"),
                              SizedBox(
                                width: 10,
                              ),
                              otherDevices("assets/tv.png", "TV"),
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

  Widget boxDesign(String title) {
    return Container(
      height: 120,
      width: 38,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isInstructionView ? MyColors.mBackColor : MyColors.lgrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_up_rounded,
                color:
                    isInstructionView ? MyColors.mainColor : MyColors.greyColor,
              )),
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                color: isInstructionView
                    ? MyColors.mainColor
                    : MyColors.greyColor),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color:
                    isInstructionView ? MyColors.mainColor : MyColors.greyColor,
              )),
        ],
      ),
    );
  }
}
