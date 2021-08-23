//Username
//Email

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:register_demo/models/person.dart';
import 'package:register_demo/models/responseData.dart';
import 'package:register_demo/screens/register/temp/registerThird.dart';
import 'package:register_demo/services/registerService.dart';
import 'package:register_demo/services/registerStorage.dart';

class SettingUserPage extends StatefulWidget {
  final Sink<bool> dataSink;
  SettingUserPage(this.dataSink);

  @override
  _SettingUserPageState createState() => _SettingUserPageState();
}

class _SettingUserPageState extends State<SettingUserPage> {
  RegisterStorage registerStorage;
  @override
  void initState() {
    super.initState();
    registerStorage = RegisterStorage.getInstance();
  }

  Person person;

  ResponseData responseData;
  String url = '';
  String diglogText = '';
  String _diglogText = '';
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isNotValidated = false;

  void setStage() {
    print("------------------SET STAGE--------------");
    bool isThirdStageComplete;
    print(passwordController.text);
    print(confirmPasswordController.text);
    registerStorage.userInformation.password = passwordController.text;
    if ((passwordController.text.length >= 4) &&
        (confirmPasswordController.text.length >= 4)) {
          if(passwordController != confirmPasswordController){

            isThirdStageComplete = false;
          }else{

          
      
      isThirdStageComplete = true;
      }
    } else {
      isThirdStageComplete = false;
    }
    print("isThirdStageComplete: " + isThirdStageComplete.toString());
    widget.dataSink.add(isThirdStageComplete);
  }

  void validate(){
    if (passwordController.text != confirmPasswordController.text){
      isNotValidated = true;
      print("isNotValidated!");
      print(isNotValidated);
    }else{
      isNotValidated = false;
    }
  }

  @override
  void dispose() {
    widget.dataSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double paddingText = 0;
    double paddingBetweenText = 00;
    double paddingTopText = 30;

    return Column(children: [
      Container(alignment: Alignment.centerLeft, child: Text("รหัสผ่าน",style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingText),
        child: TextFormField(
          obscureText: true,
          controller: passwordController,
          onChanged: (text) {
            setStage();
          },
          decoration: InputDecoration(counterText: ''),
          maxLength: 30,
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: paddingTopText),
          child: Text("ยืนยันรหัสผ่าน",style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingText),
        child: TextFormField(
          obscureText: true,
          controller: confirmPasswordController,
          onChanged: (text) {
            setStage();
            validate();
          },
          decoration: InputDecoration(
            counterText: '',
          ),
          maxLength: 30,
          keyboardType: TextInputType.emailAddress,
        ),
      ),

      Container(
          alignment: Alignment.centerLeft,
          child:
      (isNotValidated)?
       Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: paddingTopText),
          child: Text("รหัสผ่านไม่ตรงกัน",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)))
          :Container()
    )]);
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
