import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Main%20Page/MainPageAC.dart';

import '../MyColors.dart';

class MainPageLamp extends StatefulWidget {
  const MainPageLamp({Key key}) : super(key: key);

  @override
  _MainPageLampState createState() => _MainPageLampState();
}

class _MainPageLampState extends State<MainPageLamp> {
  bool isInstructionView = false;
  double _currentSliderValue = 10;

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
                      "Main Light 1",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 180,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 99,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isInstructionView
                                ? MyColors.mBackColor
                                : MyColors.backGroundColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Brightness",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: isInstructionView
                                      ? MyColors.mainColor
                                      : Colors.grey),
                            ),
                            Text(
                              _currentSliderValue.toString().substring(0, 2) +
                                  " %",
                              style: TextStyle(
                                  fontSize: 32,
                                  color: isInstructionView
                                      ? MyColors.mainColor
                                      : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Slider(
                      activeColor:
                          isInstructionView ? MyColors.orng : Colors.grey,
                      inactiveColor: isInstructionView
                          ? MyColors.mBackColor
                          : MyColors.backGroundColor,
                      value: _currentSliderValue,
                      max: 100,
                      divisions: 10,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                      },
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
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MainPageAC()));
                                  },
                                  child: otherDevices("assets/ac.png", "AC")),
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
              Positioned(
                  right: 30,
                  child: isInstructionView
                      ? Image.asset(
                          "assets/mainlight.png",
                          height: 350,
                          width: 139,
                        )
                      : Image.asset(
                          "assets/lightoff.png",
                          height: 313,
                          width: 139,
                        ))
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
}
