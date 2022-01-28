import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/DBHelper/Environment.dart';
import 'package:smart_home/Models/PIconModel.dart';
import 'package:smart_home/Models/PremisesDetails.dart';
import 'package:smart_home/Models/PremisesGet.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import '../MyColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPremisesOneOne extends StatefulWidget {
  final String uID;

  const AddPremisesOneOne({Key key, this.uID}) : super(key: key);

  @override
  _AddPremisesOneOneState createState() => _AddPremisesOneOneState();
}

class _AddPremisesOneOneState extends State<AddPremisesOneOne> {
  SharedPreferences sharedPreferences;

  List<PIconData> PIconList = List();
  bool isLoad = true;
  String uID = "";
  bool imgSel = false;
  TextEditingController roomName = TextEditingController();
  bool roomName_validate;
  String roomName_error;
  int tapped;

  @override
  void initState() {
    super.initState();
    roomName_validate = false;
    roomName_error = "";
    uID = widget.uID;
    start();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        body: isLoad
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Add Premises",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
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
                                          if (imgSel == false) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Please select Icon")));
                                          }
                                          if (validate() == 0) {
                                            /* PremisesDetails obj =
                                                PremisesDetails(
                                                    PIconList[tapped]
                                                        .piId
                                                        .toString(),
                                                    roomName.text);
                                            PremisesGet.details.add(obj);*/
                                            insertUserPremises(PIconList[tapped]
                                                .piId
                                                .toString());
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
                                  "Enter Premises Name",
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
                                errorText:
                                    roomName_validate ? roomName_error : null,
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
                              height: MediaQuery.of(context).size.height,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 5,
                                          crossAxisCount: (orientation ==
                                                  Orientation.portrait)
                                              ? 3
                                              : 3),
                                  itemCount: PIconList.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    return Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                tapped = index;
                                                imgSel = true;
                                              });
                                            },
                                            child: boxDesign(
                                                PIconList[index].dImage,
                                                PIconList[index].eImage,
                                                index)));
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

  Widget boxDesign(String img, String changeimg, int val) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: MyColors.lgrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Image.network(
          tapped == val
              ? Environment.imageUrl + changeimg
              : Environment.imageUrl + img,
          height: 50,
          width: 50,
          //     color: tapped == val ? MyColors.mainColor : Colors.grey,
        ),
      ),
    );
  }

  Future<List<PIconModel>> fetchPremises() async {
    var result = await APIService().fetchPremises();
    setState(() {
      PIconList = result.data;
      isLoad = false;
    });
  }

  Future<ResponseModel> insertUserPremises(String pi_id) async {
    Map<String, dynamic> map = Map();
    map["user_id"] = uID;
    map["pi_id"] = pi_id;
    map["premises_name"] = roomName.text;

    print(map);
    var result = await APIService().insertUserPremises(map);
    if (result.message == "success") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));
      Navigator.pop(context);
      print("Success");
    } else if (result.message == "Already Exist") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Premises Name Already Exist")));
      print("NAme");
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
      print("Erro");
    }
  }

  Future<void> getSp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> start() async {
    await getSp();
    fetchPremises();
    print(sharedPreferences.getString("UserId") + " ONE ONE");
  }
}
