import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Bottom/Bottom.dart';
import 'MyColors.dart';
import 'Registration/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MyColors.generateMaterialColor(MyColors.mainColor),
          primaryColor: MyColors.mainColor,
        ),
        home: Login());
  }

/*  Future<bool> Path() async {
    if (sharedPreferences.getString("status") == "loggedin") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Bottom()),
          (Route<dynamic> route) => false);
    }
  }

  void Status() async {
    sharedPreferences = await SharedPreferences.getInstance();
    Path();
  }*/
}

/*
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/mainlight.png"),
      ),
    );
  }
}
*/
