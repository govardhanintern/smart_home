import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/Models/PremisesDetails.dart';
import 'package:smart_home/Models/PremisesGet.dart';
import '../MyColors.dart';

class AddPremisesOneOne extends StatefulWidget {
  const AddPremisesOneOne({Key key}) : super(key: key);

  @override
  _AddPremisesOneOneState createState() => _AddPremisesOneOneState();
}

class _AddPremisesOneOneState extends State<AddPremisesOneOne> {
  List<String> addRoomList = [
    "assets/livingroom.png",
    "assets/bedrom.png",
    "assets/kitchen.png",
    "assets/office.png",
    "assets/kidsroom.png"
  ];

  TextEditingController roomName = TextEditingController();
  bool roomName_validate;
  String roomName_error;
  int tapped;

  @override
  void initState() {
    super.initState();
    roomName_validate = false;
    roomName_error = "";
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
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
                              "Add Room",
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
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                if (validate() == 0) {
                                  if (addRoomList[tapped].length==0) {
                                    print("Select Icon");
                                  } else {
                                    print("Next");
                                  }
                                  /*  PremisesDetails obj = PremisesDetails(
                                      addRoomList[tapped].toString(),
                                      roomName.text);
                                  PremisesGet.details.add(obj);
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPremises()));*/
                                }
                              },
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
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Room’s Name",
                        style: TextStyle(
                            color: MyColors.secondColor,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    maxLines: 1,
                    controller: roomName,
                    decoration: InputDecoration(
                      errorText: roomName_validate ? roomName_error : null,
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Room Icon",
                        style: TextStyle(
                            color: MyColors.secondColor,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 400,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 3 : 3),
                        itemCount: addRoomList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      tapped = index;
                                    });
                                  },
                                  child: boxDesign(addRoomList[index], index)));
                          // return Container(child: Text("hello"), color: MyColors.red,);
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  int validate() {
    int cnt = 0;
    if (roomName.text.isEmpty) {
      setState(() {
        roomName_validate = true;
        roomName_error = "Enter Room Name";
      });
      cnt++;
    } else {
      setState(() {
        roomName_validate = false;
        roomName_error = "";
      });
    }
    return cnt;
  }

  Widget boxDesign(String img, int val) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: MyColors.lgrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Image.asset(
          img,
          height: 30,
          width: 30,
          color: tapped == val ? MyColors.mainColor : Colors.grey,
        ),
      ),
    );
  }
}
