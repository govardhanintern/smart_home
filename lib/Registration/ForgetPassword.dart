import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import 'package:smart_home/Registration/EnterOTP.dart';
import '../MyColors.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController mobile = TextEditingController();
  bool mobile_validate;
  String mobile_error;
  bool isVisible = false;

  @override
  void initState() {
    mobile_validate = false;
    mobile_error = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 15, right: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/forgot.png",
                  height: 280,
                  width: 280,
                ),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Forget Password ?",
                      style: TextStyle(
                          color: MyColors.secondColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Don’t worry! it happens.Enter mobile number associated with your account.",
                      style: TextStyle(color: MyColors.grey, fontSize: 14),
                    )),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mobile Number",
                      style: TextStyle(color: MyColors.secondColor),
                    )),
                SizedBox(
                  height: 8,
                ),
                mainTextField(mobile),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Visibility(
                      visible: isVisible,
                      child: Text(
                        "Mobile Number Is Not Exist",
                        style: TextStyle(color: MyColors.red),
                      ),
                    )),
                SizedBox(
                  height: 50,
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
                              verifyMobile();
                            }
                          }
                        },
                        child: Text("Submit"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<ResponseModel> verifyMobile() async {
    Map<String, dynamic> map = Map();
    map["user_mobile"] = mobile.text;

    var result = await APIService().verifyMobile(map);
    if (result.message == "success") {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EnterOTP(
                    mobileNumber: mobile.text,
                  )));
      setState(() {
        isVisible = false;
      });
      /* ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Success")));*/
    } else {
      /*ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Mobile Number is Not Exist")));*/
      setState(() {
        isVisible = true;
      });
    }
  }

  Widget mainTextField(TextEditingController controller) {
    return TextField(
      maxLines: 1,
      maxLength: 10,
      controller: controller,
      decoration: InputDecoration(
        errorText: mobile_validate ? mobile_error : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  int validate() {
    int cnt = 0;
    if (mobile.text.isEmpty) {
      setState(() {
        mobile_validate = true;
        mobile_error = "Enter Mobile number";
      });
      cnt++;
    } else {
      mobile_validate = false;
      mobile_error = "";
    }
    return cnt;
  }
}
