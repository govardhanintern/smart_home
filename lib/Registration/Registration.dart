import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Add%20premises/AddPremises.dart';
import 'package:smart_home/Add%20premises/AddPremisesOneOne.dart';
import 'package:smart_home/Add%20premises/SelectedPremises.dart';
import 'package:smart_home/DBHelper/APIService.dart';
import 'package:smart_home/Models/ResponseModel.dart';
import 'package:smart_home/MyColors.dart';
import 'package:smart_home/Registration/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  SharedPreferences sharedPreferences;

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
      pincode_validate,
      uniqueID_validate,
      ssid_validate,
      city_validate,
      state_validate,
      wifiPass_validate;

  String name_error,
      pass_error,
      confirmPass_error,
      mobile_error,
      pincode_error,
      uniqueID_error,
      ssid_error,
      city_error,
      state_error,
      wifiPass_error;

  bool _passwordVisible = false;
  bool _CpasswordVisible = false;

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  void initState() {
    name_validate = pass_validate = confirmPass_validate = mobile_validate =
        pincode_validate = city_validate = state_validate =
            uniqueID_validate = ssid_validate = wifiPass_validate = false;
    name_error = pass_error = confirmPass_error = mobile_error = pincode_error =
        city_error =
            state_error = uniqueID_error = ssid_error = wifiPass_error = "";
    _passwordVisible = false;
    _CpasswordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 80, left: 25, right: 25, bottom: 40),
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
              TextField(
                maxLines: 1,
                controller: email,
                onChanged: (text) {
                  setState(() {
                    email = email;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: email.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                email.clear();
                              });
                            },
                            icon: Icon(Icons.highlight_remove))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              headText("Address"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: address,
                onChanged: (text) {
                  setState(() {
                    address = address;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: address.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                address.clear();
                              });
                            },
                            icon: Icon(Icons.highlight_remove))),
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 20,
              ),
              headText("Pincode"),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: pincode,
                maxLines: 1,
                maxLength: 6,
                onChanged: (text) {
                  setState(() {
                    pincode = pincode;
                  });
                },
                decoration: InputDecoration(
                    errorText: pincode_validate ? pincode_error : null,
                    border: OutlineInputBorder(),
                    suffixIcon: pincode.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                pincode.clear();
                              });
                            },
                            icon: Icon(Icons.highlight_remove))),
                keyboardType: TextInputType.number,
              ),
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
                        mainTextField(city, city_validate, city_error)
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
                        mainTextField(state, state_validate, state_error),
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
              headText("WIFI Name"),
              SizedBox(
                height: 10,
              ),
              mainTextField(ssid, ssid_validate, ssid_error),
              SizedBox(
                height: 20,
              ),
              headText("WIFI Password"),
              SizedBox(
                height: 10,
              ),
              mainTextField(wifiPass, wifiPass_validate, wifiPass_error),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                    height: 45,
                    width: 140,
                    child: ElevatedButton(
                        onPressed: () {
                          if (validate() == 0) {
                            if (password.text == confirmPass.text) {
                              if (mobile.text.length < 10) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Please Enter valid Mobile Number")));
                              } else {
                                if (email.text.isEmpty) {
                                  signIn();
                                } else {
                                  if (validateEmail(email.text)) {
                                    signIn();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Please Enter valid Email")));
                                  }
                                }
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Password Don't Match")));
                            }
                          }
                          /*  Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddPremises()));*/
                        },
                        child: Text("Submit"))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ResponseModel> signIn() async {
    Map<String, dynamic> map = Map();
    map["ud_name"] = username.text;
    map["user_mobile"] = mobile.text;
    map["ud_email"] = email.text;
    map["ud_address"] = address.text;
    map["ud_pincode"] = pincode.text;
    map["user_password"] = password.text;
    map["state"] = state.text;
    map["city"] = city.text;
    map["unique_id"] = uniqueID.text;
    map["ss_id"] = ssid.text;
    map["wifi_password"] = wifiPass.text;
    map["user_status"] = "User";

    var result = await APIService().signUp(map);
    if (result.message == "ID Not Exist") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unique Id Don't Match")));
    } else if (result.message == "Unique Id Already Assigned") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Unique Id Already Assigned")));
    } else if (result.message == "Mobile Already Exist") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Mobile Already Exist")));
    } else if (result.message == "success") {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddPremises(uID: result.userId.toString())));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Somthing Went Wrong Contact to Admin")));
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
      onChanged: (text) {
        setState(() {
          controller = controller;
        });
      },
      decoration: InputDecoration(
          errorText: val ? error : null,
          border: OutlineInputBorder(),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  icon: Icon(Icons.highlight_remove))),
      keyboardType: TextInputType.text,
    );
  }

  Widget numberField(TextEditingController controller, bool val, String error) {
    return TextField(
      controller: controller,
      maxLines: 1,
      maxLength: 10,
      onChanged: (text) {
        setState(() {
          controller = controller;
        });
      },
      decoration: InputDecoration(
          errorText: val ? error : null,
          border: OutlineInputBorder(),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      controller.clear();
                    });
                  },
                  icon: Icon(Icons.highlight_remove))),
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
    if (city.text.isEmpty) {
      setState(() {
        city_validate = true;
        city_error = "Enter City";
      });
      cnt++;
    } else {
      setState(() {
        city_validate = false;
        city_error = "";
      });
    }
    if (state.text.isEmpty) {
      setState(() {
        state_validate = true;
        state_error = "Enter State";
      });
      cnt++;
    } else {
      setState(() {
        state_validate = false;
        state_error = "";
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
        ssid_error = "Enter WIFI Name";
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
