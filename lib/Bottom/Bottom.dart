import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/Bottom/NotificationShow.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/FetchUserDetails.dart';
import 'package:smart_home/Models/FetchUserList.dart';
import 'package:smart_home/Registration/Login.dart';
import '../../MyColors.dart';
import 'AddUser.dart';
import 'Home.dart';
import 'Setting.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;
  PageController _pageController;
  SharedPreferences sharedPreferences;
  String uName = "";

  @override
  void initState() {
    super.initState();
    start();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.mainColor),
          primaryColor: MyColors.mainColor,
        ),
        child: Scaffold(
          key: _key,
          drawer: Drawer(
            child: Container(
              color: MyColors.mainColor,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    "assets/demo.png",
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => null));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.home_outlined,
                        color: MyColors.white,
                      ),
                      title: Text('My Devices',
                          style: TextStyle(color: MyColors.white)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => null));
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications_none,
                        color: MyColors.white,
                      ),
                      title: Text('Notification',
                          style: TextStyle(color: MyColors.white)),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.people_rounded,
                      color: MyColors.white,
                    ),
                    title: Text('Family access',
                        style: TextStyle(color: MyColors.white)),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline_rounded,
                      color: MyColors.white,
                    ),
                    title: Text(
                      'Support',
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      showAlertDialog();
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: MyColors.white,
                      ),
                      title: Text(
                        'Sign Out',
                        style: TextStyle(color: MyColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Container(
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
                                  onPressed: () =>
                                      _key.currentState.openDrawer(),
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
                          "Welcome $uName !",
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
              ),
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  children: <Widget>[
                    Home(),
                    AddUser(),
                    NotificationShow(),
                    Setting(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavyBar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.home)),
              BottomNavyBarItem(
                  title: Text('Add User'), icon: Icon(Icons.person_add_alt)),
              BottomNavyBarItem(
                  title: Text('Notification'),
                  icon: Icon(Icons.notifications_none)),
              BottomNavyBarItem(
                  title: Text('Setting'), icon: Icon(Icons.settings)),
            ],
          ),
        ));
  }

  void showAlertDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text('Are you sure you want to Logout'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'NO'),
            child: Text('NO'),
          ),
          TextButton(
            onPressed: () => logout(),
            child: Text('YES'),
          ),
        ],
      ),
    );
  }

  Future<void> fetchUserDetails() async {
    Map<String, dynamic> map = Map();
    map["user_id"] = sharedPreferences.getString("UserId");

    FetchUserDetails result = await APIService().fetchUserDetails(map);
    setState(() {
      uName = result.userDetail.udName;
    });
  }

  void logout() {
    sharedPreferences.setString("status", "logout");
    sharedPreferences.setString("UserId", "");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  void start() async {
    sharedPreferences = await SharedPreferences.getInstance();
    fetchUserDetails();
  }
}
