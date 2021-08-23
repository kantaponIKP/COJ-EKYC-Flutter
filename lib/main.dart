import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:register_demo/screens/login.dart';
import 'package:register_demo/screens/register/consentPage.dart';
import 'package:register_demo/screens/register/registerSuccessPage.dart';
import 'package:register_demo/screens/register/stepperPage.dart';

Future<void> main() async {
  // HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.red[400],
        disabledColor: Colors.grey[400],
      ),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/consent': (context) => ConsentPage(),
        '/register': (context) => StepperPage(),
        '/registerSuccess': (context) => RegisterSuccessPage(),
      },
    );
  }
}

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
