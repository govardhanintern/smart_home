import 'package:flutter/material.dart';
import 'package:smart_home/Bottom/NotificationShow.dart';
import '../../MyColors.dart';
import 'AddUser.dart';
import 'Home.dart';
import 'Setting.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.mainColor),
          primaryColor: MyColors.mainColor,
        ),
        child: Scaffold(
          drawer: Drawer(
            child: Container(
              color: MyColors.mainColor,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50,),
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
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: MyColors.white,
                    ),
                    title: Text(
                      'Sign Out',
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SizedBox.expand(
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
}
