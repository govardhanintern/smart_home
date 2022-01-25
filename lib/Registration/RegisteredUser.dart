import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/MyColors.dart';

class RegisteredUser extends StatefulWidget {
  const RegisteredUser({Key key}) : super(key: key);

  @override
  _RegisteredUserState createState() => _RegisteredUserState();
}

class _RegisteredUserState extends State<RegisteredUser> {
  List<String> userName = [
    "User 1",
    "User 2",
    "User 3",
    "User 4",
    "User 5",
  ];
  List<String> userMobile = [
    "9827384993",
    "8973627117",
    "7836271773",
    "8974636225",
    "9083728117",
  ];
  TextEditingController searchText = TextEditingController();

  void clearText() {
    searchText.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: MyColors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 50),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 8, right: 8),
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
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: userMobile.length,
                    itemBuilder: (_, i) =>
                        userDesign(userName[i], userMobile[i]),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget userDesign(String uName, String umobile) {
    return Container(
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
          Text(
            "User Name : " + uName,
            style: TextStyle(fontSize: 16, color: MyColors.mainColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text("Mobile : " + umobile)
        ],
      ),
    );
  }
}
