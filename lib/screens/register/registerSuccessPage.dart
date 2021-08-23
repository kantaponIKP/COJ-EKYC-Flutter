import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:register_demo/models/user.dart';
import 'package:register_demo/services/loginService.dart';
import 'package:register_demo/services/registerStorage.dart';
import 'package:register_demo/services/userService.dart';

import '../home.dart';

const consentHeaderText = "ระบบได้รับข้อมูลการลงทะเบียนของท่านเรียบร้อยแล้ว";
const consentBodyText = "";

class RegisterSuccessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterSuccessPageState();
  }
}

class _RegisterSuccessPageState extends State<RegisterSuccessPage> {
  LoginService loginService;
  UserService userService;
  User user;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String groupValue = "";

  login() {
    log("--- login ---");
    loginService.login();
  }

  onPressedComplete() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // screenSize.width * 0.1, right: screenSize.width * 0.1
    return SafeArea(
        minimum: const EdgeInsets.only(bottom: 45),
        child: Scaffold(
            appBar: AppBar(
              //  backgroundColor: Colors.white,
              title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "ลงทะเบียนสำเร็จ",
                    //  style: TextStyle(color: Colors.black)
                  )),
              // ,
              // iconTheme: IconThemeData(color: Colors.red),
              // centerTitle: true,
              // leading: IconButton(
              //   icon: Icon(Icons.arrow_back),
              //   onPressed: () => backNavigator(),
              // ),
            ),
            body: Container(
              child: ListView(
                children: <Widget>[
                    Center(
                      child: Container(
                              margin: const EdgeInsets.only(top:100.0),
                              height: screenSize.height * 0.15,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                      child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: screenSize.height * 0.06,
                                    child: new Icon(Icons.check,
                                        color: Colors.white,
                                        size: screenSize.height * 0.07),
                                  ))),
                            ),
                    ),
                          Padding(
                            padding: const EdgeInsets.all(36.0),
                              child: Text(consentHeaderText,textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize:20)),
                            ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.all(20.0),
                  //   child: Card(
                  //       child: Container(
                  //     margin: const EdgeInsets.all(20.0),
                  //     child: Column(
                  //       children: [
                  //         Container(
                  //           margin: const EdgeInsets.all(10.0),
                  //           height: screenSize.height * 0.5,
                  //           child: SingleChildScrollView(
                  //               scrollDirection: Axis.vertical,
                  //               child: Container(
                  //                   child: CircleAvatar(
                  //                 backgroundColor: Colors.green,
                  //                 radius: screenSize.height * 0.05,
                  //                 child: new Icon(Icons.check,
                  //                     color: Colors.white,
                  //                     size: screenSize.height * 0.05),
                  //               ))),
                  //         ),
                  //         Text(consentHeaderText,
                  //             style: TextStyle(fontWeight: FontWeight.bold)),
                  //       ],
                  //     ),
                  //   )),
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
                child: ElevatedButton(
                    // color: Colors.redAccent,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      onPressedComplete();
                    },
                    child: Text("เสร็จสิ้น",
                        style: TextStyle(
                          fontSize: 16,
                          // color: Colors.white
                        ))))));
  }
}
