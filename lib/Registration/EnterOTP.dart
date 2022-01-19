import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_home/Registration/ForgetPassword.dart';
import 'package:smart_home/Registration/ResetPassword.dart';

import '../MyColors.dart';

class EnterOTP extends StatefulWidget {
  final String mobileNumber;

  const EnterOTP({Key key, this.mobileNumber}) : super(key: key);

  @override
  _EnterOTPState createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  TextEditingController otp = TextEditingController();
  bool otp_validate;
  String otp_error;
  String currentText = "";
  String mobileNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDReceived = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    mobileNumber = widget.mobileNumber;
    otp_validate = false;
    otp_error = "";
    print(mobileNumber);
    verifyNumebr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 80, left: 15, right: 15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/otp.png",
                        height: 280,
                        width: 280,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Please Enter OTP ?",
                            style: TextStyle(
                                color: MyColors.secondColor,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "OTP",
                            style: TextStyle(color: MyColors.secondColor),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      mainTextField(otp),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPassword()));
                              },
                              child: Text(
                                "Change Number",
                                style: TextStyle(
                                    fontSize: 15, color: MyColors.secondColor),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: GestureDetector(
                              onTap: () {
                                verifyNumebr();
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: MyColors.secondColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                          height: 45,
                          width: 140,
                          child: ElevatedButton(
                              onPressed: () {
                                if (validate() == 0) {
                                  /* Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResetPassword()));*/
                                  verifyCode();
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

  Widget mainTextField(TextEditingController controller) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: controller,
      onCompleted: (v) {
        debugPrint("Completed");
      },
      onChanged: (value) {
        debugPrint(value);
        setState(() {
          currentText = value;
        });
      },
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    );
  }

  int validate() {
    int cnt = 0;
    if (otp.text.isEmpty) {
      setState(() {
        otp_validate = true;
        otp_error = "Enter OTP";
      });
      cnt++;
    } else {
      otp_validate = false;
      otp_error = "";
    }
    return cnt;
  }

  void verifyNumebr() {
    auth.verifyPhoneNumber(
        phoneNumber: "+91" + mobileNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((value) {
            print("authSign");
          });
        },
        verificationFailed: (FirebaseException exception) {
          print("verificationFailed");
          print(exception.message);
        },
        codeSent: (String verificationID, int resendToken) {
          verificationIDReceived = verificationID;
          print("codeSent");
          setState(() {
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived, smsCode: currentText);
    try {
      await auth.signInWithCredential(credential).then((value) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword()));
      });
    } catch (e1) {
      print("yassssssh $e1");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Code")));
    }
  }
}
