import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:register_demo/models/userInformation.dart';

class RegisterService {
  static Future<http.Response> postRequest(
      UserInformation userInformation) async {
    // var url = 'http://10.0.2.2:3000/images/upload/';
    // var url = 'http://localhost:3001/api/users';
    // var url = 'http://10.0.2.2:3001/api/users/';
    var url = Uri.parse('http://cios-api.di.iknowplus.co.th/user');

    Map data = {
      'id': userInformation.idno,
      'password': userInformation.password,
      'telephone': userInformation.tel
    };

    // Map data = {
    //   "id": "test11",
    //   "password": "test22",
    //   "telephone": "test33"
    // };

    // Map data = {
    //   "user": user,
    //   "redirect_url": "https://mobile.test.iknowplus.co.th/app",
    // };

    // print("Post: " +
    //     userInformation.idno +
    //     " " +
    //     userInformation.password +
    //     " " +
    //     userInformation.tel +
    //     "register");
    print(data);
    print("------Response-----");
    //encode Map to JSON
    var body = json.encode(data);
    try {
      print("------Response-----1");
      final response = await http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .timeout(const Duration(seconds: 5));
      // final response = await http.post(
      //     Uri.parse('http://cios-api.di.iknowplus.co.th/user'),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //     },
      //     body: jsonEncode(<String, String>{
      //       'id': 'test11',
      //       'password': 'test22',
      //       'telephone': 'test33'
      //     }),
      //   );

      print("statusCode: ${response.statusCode}");
      print("body: ${response.body}");
      return response;
    } on TimeoutException catch (_) {
      print("------Response-----2");
      print('Timeout');
    } on Error catch (e) {
      print("------Response-----3");
      print('Error: $e');
    }
    return null;
  }
  
}
