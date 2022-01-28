import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/FetchUserList.dart';
import 'package:smart_home/MyColors.dart';
import 'package:smart_home/Registration/Registration.dart';
import 'dart:io' show Platform, exit;

class RegisteredUser extends StatefulWidget {
  const RegisteredUser({Key key}) : super(key: key);

  @override
  _RegisteredUserState createState() => _RegisteredUserState();
}

class _RegisteredUserState extends State<RegisteredUser> {
  TextEditingController searchText = TextEditingController();
  List<UserListData> userList = [];
  bool isLoad = true;

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void clearText() {
    searchText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Do something here
          print("After clicking the Android Back Button");
          showAlertDialog();
          return false;
        },
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: IconButton(
                onPressed: () {
                  //  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Registration())).then((value) {
                    fetchUser();
                  });
                },
                icon: Icon(
                  Icons.add,
                  size: 30,
                  color: MyColors.white,
                ),
              ),
            ),
            body: isLoad
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8, right: 8, top: 50),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 8, right: 8),
                            child: TextField(
                              maxLength: 10,
                              controller: searchText,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.go,
                              onSubmitted: (value) {
                                //_firstLoad();
                                // searchApi();
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Mobile to Search ",
                                hintStyle: TextStyle(color: Colors.grey),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                    onPressed: clearText,
                                    icon: Icon(Icons.highlight_remove)),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: EdgeInsets.all(8),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade100)),
                              ),
                            ),
                          ),
                          userList.isEmpty
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text("No User"))
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    primary: false,
                                    scrollDirection: Axis.vertical,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemCount: userList.length,
                                    itemBuilder: (_, i) =>
                                        userDesign(userList[i]),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )));
  }

  Widget userDesign(UserListData uData) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddPremises(uID: uData.user.userId.toString())));
      },
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2.0,
          ),
        ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  flex: 6,
                  fit: FlexFit.tight,
                  child: Text(
                    "User Name : " + uData.userDetail.udName,
                    style: TextStyle(fontSize: 18, color: MyColors.mainColor),
                  ),
                ),
                Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPremises(
                                      uID: uData.user.userId.toString())));
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 15,
                        )))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("Mobile : " + uData.user.userMobile)
          ],
        ),
      ),
    );
  }

  void showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure want close this application'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              bool plat = Platform.isAndroid;
              if (plat) {
                SystemNavigator.pop();
              } else {
                exit(0);
              }
            },
            child: Text('YES'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('NO'),
          ),
        ],
      ),
    );
  }

  Future<List<void>> fetchUser() async {
    FetchUserList result = await APIService().fetchAllUsers();
    setState(() {
      userList = result.data;
      isLoad = false;
    });
  }
}
