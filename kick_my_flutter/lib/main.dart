import 'package:flutter/material.dart';
import 'Acceuil.dart';
import 'Login.dart';

void main() {
  runApp(MyApp());
}

//APPLICATION
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: LoginScreen(),
      routes: <String, WidgetBuilder>{
        "/screen1": (BuildContext context) => new LoginScreen(),
        "/screen2": (BuildContext context) => new Acceuil(),
      },
    );
  }
}



