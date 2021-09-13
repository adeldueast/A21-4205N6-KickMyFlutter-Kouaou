import 'package:flutter/material.dart';
import 'Acceuil.dart';
import 'Consultation.dart';
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
      title: "TodoApp",
     theme: ThemeData(fontFamily: "Poppins"),
     initialRoute: "/screen1",
      routes: <String, WidgetBuilder>{
        "/screen1": (BuildContext context) => new LoginScreen(),
        "/screen2": (BuildContext context) => new Acceuil(),
        "/screen3": (BuildContext context) => new Consultation(),

      },
    );
  }
}



