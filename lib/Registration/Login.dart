import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/Bottom/Bottom.dart';
import 'package:smart_home/Bottom/Home.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import 'package:smart_home/Registration/Registration.dart';

import '../MyColors.dart';
import 'ForgetPassword.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _passwordVisible = false;
  bool mobile_validate, pass_validate;
  String mobile_error, pass_error;

  @override
  void initState() {
    mobile_validate = pass_validate = false;
    mobile_error = pass_error = "";
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 90, left: 15, right: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/login.png",
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "User Mobile",
                      style: TextStyle(color: MyColors.secondColor),
                    )),
                SizedBox(
                  height: 8,
                ),
                mainTextField(mobile, mobile_validate, mobile_error),
                SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(color: MyColors.secondColor),
                    )),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible,
                  maxLines: 1,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: pass_validate ? pass_error : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                      child: Text(
                        "Forget password",
                        style: TextStyle(color: MyColors.mainColor),
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 45,
                    width: 140,
                    child: ElevatedButton(
                        onPressed: () {
                          if (validate() == 0) {
                            if (mobile.text.length < 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Enter valid Mobile Number")));
                            } else {
                              /* Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Bottom()));*/
                              login();
                            }
                          }
                        },
                        child: Text("Login"))),
                SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Registration()));
                  },
                  child: RichText(
                      text: TextSpan(
                          text: 'New here? ',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                        TextSpan(
                            text: 'Register',
                            style: TextStyle(
                                color: MyColors.mainColor, fontSize: 15)),
                      ])),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(
                        "assets/facebook.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 80,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(
                        "assets/instagram.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 80,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      child: Image.asset(
                        "assets/link.png",
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ResponseModel> login() async {
    Map<String, dynamic> map = Map();
    map["user_mobile"] = mobile.text;
    map["user_password"] = password.text;

    var result = await APIService().login(map);
    if (result.message == "success") {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Bottom()));
   /*   ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));*/
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Contact to Admin")));
    }
  }

  int validate() {
    int cnt = 0;
    if (mobile.text.isEmpty) {
      setState(() {
        mobile_validate = true;
        mobile_error = "Enter mobile number";
      });
      cnt++;
    } else {
      setState(() {
        mobile_validate = false;
        mobile_error = "";
      });
    }
    if (password.text.isEmpty) {
      setState(() {
        pass_validate = true;
        pass_error = "Enter Password";
      });
      cnt++;
    } else {
      setState(() {
        pass_validate = false;
        pass_error = "";
      });
    }
    return cnt;
  }

  Widget mainTextField(
      TextEditingController controller, bool val, String error) {
    return TextField(
      maxLines: 1,
      maxLength: 10,
      controller: controller,
      decoration: InputDecoration(
        errorText: val ? error : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
