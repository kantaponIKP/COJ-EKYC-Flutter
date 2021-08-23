//Username
//Email

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:register_demo/models/person.dart';
import 'package:register_demo/models/responseData.dart';
import 'package:register_demo/models/userInformation.dart';
import 'package:register_demo/screens/register/temp/registerThird.dart';
import 'package:register_demo/services/registerService.dart';
import 'package:register_demo/services/registerStorage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class IdentificationNoPage extends StatefulWidget {
  final Sink<bool> dataSink;
  IdentificationNoPage(this.dataSink);

  @override
  _IdentificationNoPageState createState() => _IdentificationNoPageState();
}

class _IdentificationNoPageState extends State<IdentificationNoPage> {
  RegisterStorage registerStorage;
  @override
  void initState() {
    super.initState();
    registerStorage = RegisterStorage.getInstance();
  }

  @override
  void dispose() {
    // widget.dataSink.close();
    widget.dataSink.close();
    super.dispose();
  }

  Person person;
  UserInformation userinformation;
  ResponseData responseData;
  String url = '';
  String diglogText = '';
  String _diglogText = '';
  TextEditingController idnoController = TextEditingController();
  TextEditingController idnoBackCardController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController subDistrictController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  String currentText = "";

  void setStage() {
    print("------------------SET STAGE--------------");
    bool isThirdStageComplete;
    print(idnoController.text);
    print(idnoController.text.length);
    print(emailController.text.length);
    registerStorage.userInformation.idno = idnoController.text;
    registerStorage.userInformation.tel = telController.text;
    if ((idnoController.text.length == 13) &&
        (emailController.text.length == 10)) {
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
    double paddingTopText = 0;
    double paddingBetweenText = 20;

    final formKey = GlobalKey<FormState>();

    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          child: Text("รหัสประจำตัวประชาชน",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: idnoController,
          onChanged: (text) {
            setStage();
          },
          decoration: InputDecoration(counterText: ''),
          maxLength: 13,
        ),
      ),
      // SizedBox(
      //   height: 16,
      // ),
      Container(
          alignment: Alignment.centerLeft,
          child: Text("เลขหลังบัตรประจำตัวประชาชน",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: idnoBackCardController,
          onChanged: (text) {
            setStage();
          },
          decoration: InputDecoration(counterText: ''),
          maxLength: 13,
        ),
      ),
      SizedBox(
        height: 48,
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Text("เบอร์มือถือ",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: telController,
          onChanged: (text) {
            setStage();
          },
          decoration: InputDecoration(counterText: ''),
          maxLength: 30,
        ),
      ),
      SizedBox(
        height: 48,
      ),
      address(context)
    ]);
  }

  Widget address(BuildContext context) {
    double paddingText = 00;
    double paddingBetweenText = 20;
    return Column(children: [
      Container(
          alignment: Alignment.centerLeft,
          child:
              Text("ที่อยู่", style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: addressController,
          onChanged: (text) {
            setStage();
          },
          // controller: idnoController,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child:
              Text("จังหวัด", style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: provinceController,
          onChanged: (text) {
            setStage();
          },
          // controller: idnoController,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Text("เขต / อำเภอ",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: districtController,
          onChanged: (text) {
            setStage();
          },
          // controller: idnoController,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Text("แขวง / ตำบล",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: subDistrictController,
          onChanged: (text) {
            setStage();
          },
          // controller: idnoController,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Text("รหัสไปรษณีย์",
              style: TextStyle(fontWeight: FontWeight.bold))),
      Container(
        padding: EdgeInsets.only(top: paddingText, bottom: paddingBetweenText),
        child: TextFormField(
          controller: zipCodeController,
          onChanged: (text) {
            setStage();
          },
          // controller: idnoController,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ]);
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
