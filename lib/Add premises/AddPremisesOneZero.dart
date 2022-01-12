import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremisesOneOne.dart';
import 'package:smart_home/MyColors.dart';

class AddPremisesOneZero extends StatefulWidget {
  const AddPremisesOneZero({Key key}) : super(key: key);

  @override
  _AddPremisesOneZeroState createState() => _AddPremisesOneZeroState();
}

class _AddPremisesOneZeroState extends State<AddPremisesOneZero> {
  String boxStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
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
            SizedBox(
              height: 8,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            boxStatus = "Living Room";
                          });
                        },
                        child:
                            boxDesign("assets/livingroom.png", "Living Room")),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            boxStatus = "Bed Room";
                          });
                        },
                        child: boxDesign("assets/bedrom.png", "Bed Room")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            boxStatus = "Kitchen";
                          });
                        },
                        child: boxDesign("assets/kitchen.png", "Kitchen")),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(onTap: (){
                      setState(() {
                        boxStatus = "Office";
                      });
                    },
                        child: boxDesign("assets/office.png", "Office")),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 114,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: MyColors.mBackColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: IconButton(
                          icon:
                              Icon(Icons.add_circle, color: MyColors.mainColor),
                        ),
                      ),
                      Text("Add Premises"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      Positioned(
        bottom: 20,
        left: 120,
        child: Container(
            height: 45,
            width: 140,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddPremisesOneOne()));
                },
                child: Text("Done"))),
      ),
    ]));
  }

  Widget boxDesign(String img, String title) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      height: 114,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(
            color: boxStatus == title ? MyColors.mainColor : Colors.white),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              img,
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
              color: boxStatus == title ? MyColors.mainColor : Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }
}
