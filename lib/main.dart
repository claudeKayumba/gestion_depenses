import 'package:depenses/pages/home_screen.dart';
import 'package:depenses/pages/pass_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences prefs;
  bool isConnected = false;
  @override
  void initState() {
    super.initState();
    init();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dependes',
      theme: ThemeData(
        primaryColor: Colors.blue[200],
        primarySwatch: Colors.blue,
      ),
      home: launcher(),
    );
  }

  Widget launcher(){
    if (isConnected) {
      return new PassCodeScreen();
    }
    return (prefs.getString('password') ?? "") != "" ? new HomeScreen() : new PassCodeScreen();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    
    setState(() {
      isConnected = (prefs.getBool('logUser') ?? false);
      prefs.setBool('logUser', isConnected);
    });
  }
}