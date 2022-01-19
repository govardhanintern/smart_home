import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/Registration/Login.dart';

import '../MyColors.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _passwordVisible = false;
  bool _cPassVisible = false;
  bool pass_validate, confirmPass_validate;
  String pass_error, confirmPass_error;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    _cPassVisible = false;
    pass_validate = confirmPass_validate = false;
    pass_error = confirmPass_error = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 100, left: 15, right: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/resetpass.png",
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 70,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                          color: MyColors.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    )),
                SizedBox(
                  height: 50,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "New Password",
                      style: TextStyle(color: MyColors.secondColor),
                    )),
                SizedBox(
                  height: 8,
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
                  height: 8,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
                      style: TextStyle(color: MyColors.secondColor),
                    )),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: confirmPass,
                  obscureText: !_cPassVisible,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    errorText: confirmPass_validate ? confirmPass_error : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _cPassVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          _cPassVisible = !_cPassVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 45,
                    width: 140,
                    child: ElevatedButton(
                        onPressed: () {
                          if (validate() == 0) {
                            if (password.text == confirmPass.text) {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Password Don't Match")));
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

  int validate() {
    int cnt = 0;
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
    return cnt;
  }
}
