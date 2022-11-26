import 'package:chat_app_firebase/auth/login_page.dart';
import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:chat_app_firebase/pages/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await helperfunction.getuserloggedinstatus().then((value) {
    if (value != null) {
      issignedin = value;
    }
    SystemChrome.setEnabledSystemUIOverlays([]);

    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: issignedin ? Homepage() : login(),
    );
  }
}
