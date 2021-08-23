//Username
//Email

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:register_demo/models/person.dart';
import 'package:register_demo/models/responseData.dart';
import 'package:register_demo/screens/register/temp/registerThird.dart';
import 'package:register_demo/services/registerService.dart';
import 'package:register_demo/services/registerStorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatefulWidget {
  final Sink<bool> dataSink;
  OtpPage(this.dataSink);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  RegisterStorage registerStorage;
  StreamController<ErrorAnimationType> errorController;
  @override
  void initState() {
    super.initState();
    registerStorage = RegisterStorage.getInstance();
    errorController = StreamController<ErrorAnimationType>.broadcast();
  }

  Person person;

  ResponseData responseData;
  String url = '';
  String diglogText = '';
  String _diglogText = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    errorController.close();
    widget.dataSink.close();
    super.dispose();
  }

  void setStage() {
    print("------------------SET STAGE--------------");
    bool isThirdStageComplete;
    print(usernameController.text);
    print(usernameController.text.length);
    print(emailController.text.length);
    if ((usernameController.text.length > 4) &&
        (emailController.text.length >= 6)) {
      registerStorage.person.username = usernameController.text;
      registerStorage.person.email = emailController.text;
      isThirdStageComplete = true;
    } else {
      isThirdStageComplete = false;
    }
    print("isThirdStageComplete: " + isThirdStageComplete.toString());
    widget.dataSink.add(isThirdStageComplete);
  }

  @override
  Widget build(BuildContext context) {
    double paddingText = 0;
    double paddingBetweenText = 00;
    double paddingTopText = 30;
    final screenSize = MediaQuery.of(context).size;
    final formKey = GlobalKey<FormState>();
    double screenSizeWidth = screenSize.width;
    print("screenSize");
    print(screenSize);
        print("screenSize");
    print(screenSize);
    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          child: Text("ยืนยัน OTP",
              style: TextStyle(fontWeight: FontWeight.bold))),
      SizedBox(
        height: 24,
      ),
      Padding(
        // padding: const EdgeInsets.only(left: 50, right: 50),
        padding: EdgeInsets.only(left: screenSizeWidth*0.12, right: screenSizeWidth*0.12),
        child: Form(
          key: formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                // obscureText: true,
                // obscuringCharacter: '*',
                // obscuringWidget: FlutterLogo(
                //   size: 24,
                // ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                // validator: (v) {
                //   if (v.length < 6) {
                //     return "Please fill up compeletely";
                //   } else {
                //     return null;
                //   }
                // },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  activeColor: Colors.blue[900],
                  selectedColor: Colors.black,
                  inactiveColor: Colors.black38,
                  // disabledColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,

                  // selectedColor: Colors.white,
                  // inactiveColor: Colors.white,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  // activeColor: Colors.white,
                  activeFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                // controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 5,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                  // print(textEditingController.text);
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  // setState(() {
                  //   currentText = value;
                  // });
                  if (mounted) {
                    // setState(() {
                    //   currentText = value;
                    // });
                  }
                  // if (mounted) {
                  //   setState(() {
                  //     currentText = value;
                  //   });
                  // }
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              )),
        ),
      ),
      Text("Don't receive an OTP?"),
      TextButton(
        style: TextButton.styleFrom(
          primary: Colors.blue[900], // foreground
        ),
        onPressed: () {
          onPressedResendOTP();
        },
        child: Text('Resend OTP'),
      )
    ]);
  }

  onPressedResendOTP() {
    showAlertDialogWithoutRetry(
        context, "Resend OTP", "ส่ง PIN (OTP) อีกครั้งแล้ว");
  }

  showFillUpAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("ตกลง",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
          )),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("ข้อความ"),
      content: Text("กรุณากรอกข้อมูลให้ครบ"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showResponseAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("ตกลง",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
          )),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("ข้อความ",
          style: TextStyle(
            color: Colors.red,
            fontSize: 30.0,
          )),
      content: Text(_diglogText),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

showAlertDialogWithoutRetry(BuildContext context, String title, String body) {
  Widget okButton = FlatButton(
    child: Text("OK",
        style: TextStyle(
          color: Colors.black38,
        )),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title,
        style: TextStyle(
          color: Colors.blue[900],
          fontSize: 20.0,
        )),
    content: Text(body),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
