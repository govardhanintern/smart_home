import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Main%20Page/MainPageAC.dart';
import 'package:smart_home/Main%20Page/MainPageFan.dart';
import 'package:smart_home/Main%20Page/MainPageLamp.dart';
import 'package:smart_home/Main%20Page/MainPageTV.dart';

import '../MyColors.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                              onPressed: () => null,
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
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          "Good Morning",
                          style: TextStyle(
                            fontSize: 12,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      Text(
                        "32 c",
                        style: TextStyle(
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "52%",
                        style: TextStyle(
                          fontSize: 12,
                          color: MyColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TabBar(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.0),
                  insets: EdgeInsets.symmetric(horizontal: 30.0)),
              isScrollable: true,
              unselectedLabelColor: Colors.grey,
              labelColor: MyColors.secondColor,
              indicatorColor: MyColors.secondColor,
              tabs: [
                Tab(
                  text: 'Living Room',
                ),
                Tab(
                  text: 'Bed Room',
                ),
                Tab(
                  text: 'Kitchen',
                ),
                Tab(
                  text: 'Office',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LivingRoomTab(),
                  BedRoomTab(),
                  KitchenTab(),
                  OfficeTab(),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LivingRoomTab extends StatefulWidget {
  const LivingRoomTab({Key key}) : super(key: key);

  @override
  _LivingRoomTabState createState() => _LivingRoomTabState();
}

class _LivingRoomTabState extends State<LivingRoomTab> {
  List<bool> isInstructionView = [false, false, false, false];
  List<String> itemName = ["Main Light", "TV", "AC", "FAN"];
  List<String> itemImage = [
    "assets/lamp.png",
    "assets/tv.png",
    "assets/ac.png",
    "assets/fan.png",
  ];
  List<String> extra = ["", "", "34 c temperature", "Speed"];

  @override
  void initState() {
    super.initState();
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(false);
  }

  /*void addItems(String iName) {
    setState(() {
      itemName.add(iName);
      isInstructionView.add(false);
    });
  }

  void addImage(String img) {
    setState(() {
      itemImage.add(img);
    });
  }

  void addExtra(String extraText) {
    setState(() {
      extra.add(extraText);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
            itemCount: itemName.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  getItemName(itemName[index].toString());
                },
                child: boxDesign(itemImage[index], itemName[index], index,
                    subTitle: extra.isEmpty ? Text("") : extra[index]),
              );
            }),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Premises",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/lamp.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Lamp'),
                        onTap: () {
                          addItems("Main Light");
                          addImage("assets/lamp.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/tv.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('TV'),
                        onTap: () {
                          addItems("TV");
                          addImage("assets/tv.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/ac.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('AC'),
                        onTap: () {
                          addItems("AC");
                          addImage("assets/ac.png");
                          addExtra("34 c temperature");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/fan.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Fan'),
                        onTap: () {
                          addItems("Fan");
                          addImage("assets/fan.png");
                          addExtra("Speed");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        label: Text('Add Premises'),
        icon: Icon(Icons.add_circle),
        backgroundColor: MyColors.mainColor,
      ),*/
    );
  }

  void getItemName(String name) {
    if (name == "TV") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageTV()));
    } else if (name == "AC") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageAC()));
    } else if (name == "FAN") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageFan()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageLamp()));
    }
  }

  Widget boxDesign(String img, String title, int index, {String subTitle}) {
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
            Text(
              subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 12),
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

class BedRoomTab extends StatefulWidget {
  const BedRoomTab({Key key}) : super(key: key);

  @override
  _BedRoomTabState createState() => _BedRoomTabState();
}

class _BedRoomTabState extends State<BedRoomTab> {
  List<bool> isInstructionView = [false, true, false];
  List<String> itemName = ["Main Light", "TV", "AC"];
  List<String> itemImage = [
    "assets/lamp.png",
    "assets/tv.png",
    "assets/ac.png",
  ];
  List<String> extra = ["", "", "34 c temperature"];

  @override
  void initState() {
    super.initState();
    isInstructionView.add(false);
    isInstructionView.add(true);
    isInstructionView.add(false);
  }

  /*void addItems(String iName) {
    setState(() {
      itemName.add(iName);
      isInstructionView.add(false);
    });
  }

  void addImage(String img) {
    setState(() {
      itemImage.add(img);
    });
  }

  void addExtra(String extraText) {
    setState(() {
      extra.add(extraText);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
            itemCount: itemName.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  getItemName(itemName[index].toString());
                },
                child: boxDesign(itemImage[index], itemName[index], index,
                    subTitle: extra.isEmpty ? Text("") : extra[index]),
              );
            }),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Premises",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/lamp.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Lamp'),
                        onTap: () {
                          addItems("Main Light");
                          addImage("assets/lamp.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/tv.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('TV'),
                        onTap: () {
                          addItems("TV");
                          addImage("assets/tv.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/ac.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('AC'),
                        onTap: () {
                          addItems("AC");
                          addImage("assets/ac.png");
                          addExtra("34 c temperature");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/fan.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Fan'),
                        onTap: () {
                          addItems("Fan");
                          addImage("assets/fan.png");
                          addExtra("Speed");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        label: Text('Add Premises'),
        icon: Icon(Icons.add_circle),
        backgroundColor: MyColors.mainColor,
      ),*/
    );
  }

  void getItemName(String name) {
    if (name == "TV") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageTV()));
    } else if (name == "AC") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageAC()));
    } else if (name == "FAN") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageFan()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageLamp()));
    }
  }

  Widget boxDesign(String img, String title, int index, {String subTitle}) {
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
            Text(
              subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 12),
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

class KitchenTab extends StatefulWidget {
  const KitchenTab({Key key}) : super(key: key);

  @override
  _KitchenTabState createState() => _KitchenTabState();
}

class _KitchenTabState extends State<KitchenTab> {
  List<bool> isInstructionView = [true, false, false, true];
  List<String> itemName = ["Main Light", "TV", "AC", "FAN"];
  List<String> itemImage = [
    "assets/lamp.png",
    "assets/tv.png",
    "assets/ac.png",
    "assets/fan.png",
  ];
  List<String> extra = ["", "", "34 c temperature", "Speed"];

  @override
  void initState() {
    super.initState();
    isInstructionView.add(true);
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(true);
  }

  /*void addItems(String iName) {
    setState(() {
      itemName.add(iName);
      isInstructionView.add(false);
    });
  }

  void addImage(String img) {
    setState(() {
      itemImage.add(img);
    });
  }

  void addExtra(String extraText) {
    setState(() {
      extra.add(extraText);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
            itemCount: itemName.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  getItemName(itemName[index].toString());
                },
                child: boxDesign(itemImage[index], itemName[index], index,
                    subTitle: extra.isEmpty ? Text("") : extra[index]),
              );
            }),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Premises",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/lamp.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Lamp'),
                        onTap: () {
                          addItems("Main Light");
                          addImage("assets/lamp.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/tv.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('TV'),
                        onTap: () {
                          addItems("TV");
                          addImage("assets/tv.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/ac.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('AC'),
                        onTap: () {
                          addItems("AC");
                          addImage("assets/ac.png");
                          addExtra("34 c temperature");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/fan.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Fan'),
                        onTap: () {
                          addItems("Fan");
                          addImage("assets/fan.png");
                          addExtra("Speed");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        label: Text('Add Premises'),
        icon: Icon(Icons.add_circle),
        backgroundColor: MyColors.mainColor,
      ),*/
    );
  }

  void getItemName(String name) {
    if (name == "TV") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageTV()));
    } else if (name == "AC") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageAC()));
    } else if (name == "FAN") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageFan()));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageLamp()));
    }
  }
  Widget boxDesign(String img, String title, int index, {String subTitle}) {
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
            Text(
              subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 12),
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

class OfficeTab extends StatefulWidget {
  const OfficeTab({Key key}) : super(key: key);

  @override
  _OfficeTabState createState() => _OfficeTabState();
}

class _OfficeTabState extends State<OfficeTab> {
  List<bool> isInstructionView = [false, true, false, true];
  List<String> itemName = ["Main Light", "TV", "AC", "FAN"];
  List<String> itemImage = [
    "assets/lamp.png",
    "assets/tv.png",
    "assets/ac.png",
    "assets/fan.png",
  ];
  List<String> extra = ["", "", "34 c temperature", "Speed"];

  @override
  void initState() {
    super.initState();
    isInstructionView.add(true);
    isInstructionView.add(false);
    isInstructionView.add(false);
    isInstructionView.add(true);
  }

  /*void addItems(String iName) {
    setState(() {
      itemName.add(iName);
      isInstructionView.add(false);
    });
  }

  void addImage(String img) {
    setState(() {
      itemImage.add(img);
    });
  }

  void addExtra(String extraText) {
    setState(() {
      extra.add(extraText);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: (orientation == Orientation.portrait) ? 2 : 2),
            itemCount: itemName.length,
            itemBuilder: (BuildContext ctx, index) {
              return GestureDetector(
                onTap: () {
                  getItemName(itemName[index].toString());
                },
                child: boxDesign(itemImage[index], itemName[index], index,
                    subTitle: extra.isEmpty ? Text("") : extra[index]),
              );
            }),
      ),
      /* floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Add Premises",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/lamp.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Lamp'),
                        onTap: () {
                          addItems("Main Light");
                          addImage("assets/lamp.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/tv.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('TV'),
                        onTap: () {
                          addItems("TV");
                          addImage("assets/tv.png");
                          addExtra("");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/ac.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('AC'),
                        onTap: () {
                          addItems("AC");
                          addImage("assets/ac.png");
                          addExtra("34 c temperature");
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Image.asset(
                          "assets/fan.png",
                          width: 30,
                          height: 30,
                        ),
                        title: new Text('Fan'),
                        onTap: () {
                          addItems("Fan");
                          addImage("assets/fan.png");
                          addExtra("Speed");
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              });
        },
        label: Text('Add Premises'),
        icon: Icon(Icons.add_circle),
        backgroundColor: MyColors.mainColor,
      ),*/
    );
  }
  void getItemName(String name) {
    if (name == "TV") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageTV()));
    } else if (name == "AC") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageAC()));
    } else if (name == "FAN") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageFan()));
    }else{
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPageLamp()));
    }
  }
  Widget boxDesign(String img, String title, int index, {String subTitle}) {
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
            Text(
              subTitle,
              style: TextStyle(color: Colors.grey, fontSize: 12),
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
