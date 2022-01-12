import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/Add%20premises/AddPremisesOneOne.dart';
import 'package:smart_home/Add%20premises/Premises.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import 'package:smart_home/MyColors.dart';
import 'package:smart_home/Registration/Login.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController uniqueID = TextEditingController();
  TextEditingController ssid = TextEditingController();
  TextEditingController wifiPass = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();

  bool name_validate,
      pass_validate,
      confirmPass_validate,
      mobile_validate,
      email_validate,
      address_validate,
      pincode_validate,
      uniqueID_validate,
      ssid_validate,
      wifiPass_validate;

  String name_error,
      pass_error,
      confirmPass_error,
      mobile_error,
      email_error,
      address_error,
      pincode_error,
      uniqueID_error,
      ssid_error,
      wifiPass_error;

  bool _passwordVisible = false;
  bool _CpasswordVisible = false;

  @override
  void initState() {
    name_validate = pass_validate = confirmPass_validate = mobile_validate =
        email_validate = address_validate = pincode_validate =
            uniqueID_validate = ssid_validate = wifiPass_validate = false;
    name_error = pass_error = confirmPass_error = mobile_error = email_error =
        address_error =
            pincode_error = uniqueID_error = ssid_error = wifiPass_error = "";
    _passwordVisible = false;
    _CpasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 150),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Registration",
                    style: TextStyle(
                        color: MyColors.secondColor,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                headText("Username"),
                SizedBox(
                  height: 10,
                ),
                mainTextField(username, name_validate, name_error),
                SizedBox(
                  height: 20,
                ),
                headText("Password"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: !_passwordVisible,
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
                  height: 20,
                ),
                headText("Confirm Password"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: !_CpasswordVisible,
                  controller: confirmPass,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: confirmPass_validate ? confirmPass_error : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _CpasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _CpasswordVisible = !_CpasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                headText("Mobile No."),
                SizedBox(
                  height: 10,
                ),
                numberField(mobile, mobile_validate, mobile_error),
                SizedBox(
                  height: 20,
                ),
                headText("Email"),
                SizedBox(
                  height: 10,
                ),
                mainTextField(email, email_validate, email_error),
                SizedBox(
                  height: 20,
                ),
                headText("Address"),
                SizedBox(
                  height: 10,
                ),
                mainTextField(address, address_validate, address_error),
                SizedBox(
                  height: 20,
                ),
                headText("Pincode"),
                SizedBox(
                  height: 10,
                ),
                numberField(pincode, pincode_validate, pincode_error),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          headText("City"),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 1,
                            controller: city,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          headText("State"),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            maxLines: 1,
                            controller: state,
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.keyboard_arrow_down),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                headText("Unique ID"),
                SizedBox(
                  height: 10,
                ),
                mainTextField(uniqueID, uniqueID_validate, uniqueID_error),
                SizedBox(
                  height: 20,
                ),
                headText("SSID"),
                SizedBox(
                  height: 10,
                ),
                numberField(ssid, ssid_validate, ssid_error),
                SizedBox(
                  height: 20,
                ),
                headText("WIFI Password"),
                SizedBox(
                  height: 10,
                ),
                mainTextField(wifiPass, wifiPass_validate, wifiPass_error)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 100,
          child: Center(
            child: Container(
                height: 45,
                width: 140,
                child: ElevatedButton(
                    onPressed: () {
                      /* if (validate() == 0) {
                        if (password.text == confirmPass.text) {
                          signIn();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password Don't Match")));
                        }
                      }*/
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddPremises()));
                    },
                    child: Text("Sign In"))),
          ),
        ),
      ]),
    );
  }

  Future<ResponseModel> signIn() async {
    Map<String, dynamic> map = Map();
    map["user_name"] = username.text;
    map["user_mobile"] = mobile.text;
    map["user_email"] = email.text;
    map["user_address"] = address.text;
    map["user_pincode"] = pincode.text;
    map["user_password"] = password.text;
    map["state"] = state.text;
    map["city"] = city.text;
    map["unique_id"] = uniqueID.text;
    map["ss_id"] = ssid.text;
    map["wifi_password"] = wifiPass.text;

    var result = await APIService().signUp(map);
    if (result.message == "ID Not Exist") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unique Id Don't Match")));
    } else if (result.message == "success") {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddPremises()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Contact to Admin")));
    }
  }

  Widget headText(String title) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(color: MyColors.secondColor),
        ));
  }

  Widget mainTextField(
      TextEditingController controller, bool val, String error) {
    return TextField(
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        errorText: val ? error : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget numberField(TextEditingController controller, bool val, String error) {
    return TextField(
      controller: controller,
      maxLines: 1,
      maxLength: 10,
      decoration: InputDecoration(
        errorText: val ? error : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
    );
  }

  int validate() {
    int cnt = 0;
    if (username.text.isEmpty) {
      setState(() {
        name_validate = true;
        name_error = "Enter Name";
      });
      cnt++;
    } else {
      setState(() {
        name_validate = false;
        name_error = "";
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
    if (confirmPass.text.isEmpty) {
      setState(() {
        confirmPass_validate = true;
        confirmPass_error = "Enter Confirm Password";
      });
      cnt++;
    } else {
      setState(() {
        confirmPass_validate = false;
        confirmPass_error = "";
      });
    }
    if (mobile.text.isEmpty) {
      setState(() {
        mobile_validate = true;
        mobile_error = "Enter Mobile";
      });
      cnt++;
    } else {
      setState(() {
        mobile_validate = false;
        mobile_error = "";
      });
    }
    if (email.text.isEmpty) {
      setState(() {
        email_validate = true;
        email_error = "Enter Email";
      });
      cnt++;
    } else {
      setState(() {
        email_validate = false;
        email_error = "";
      });
    }
    if (address.text.isEmpty) {
      setState(() {
        address_validate = true;
        address_error = "Enter Address";
      });
      cnt++;
    } else {
      setState(() {
        address_validate = false;
        address_error = "";
      });
    }
    if (pincode.text.isEmpty) {
      setState(() {
        pincode_validate = true;
        pincode_error = "Enter Pincode";
      });
      cnt++;
    } else {
      setState(() {
        pincode_validate = false;
        pincode_error = "";
      });
    }
    if (uniqueID.text.isEmpty) {
      setState(() {
        uniqueID_validate = true;
        uniqueID_error = "Enter Unique ID";
      });
      cnt++;
    } else {
      setState(() {
        uniqueID_validate = false;
        uniqueID_error = "";
      });
    }
    if (ssid.text.isEmpty) {
      setState(() {
        ssid_validate = true;
        ssid_error = "Enter SSID";
      });
      cnt++;
    } else {
      setState(() {
        ssid_validate = false;
        ssid_error = "";
      });
    }
    if (wifiPass.text.isEmpty) {
      setState(() {
        wifiPass_validate = true;
        wifiPass_error = "Enter WIFI Password";
      });
      cnt++;
    } else {
      setState(() {
        wifiPass_validate = false;
        wifiPass_error = "";
      });
    }
    return cnt;
  }
}
