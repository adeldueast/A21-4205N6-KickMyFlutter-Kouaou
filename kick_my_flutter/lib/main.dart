import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kick_my_flutter/Activities/Creation.dart';
import 'package:kick_my_flutter/i18n/intl_delegate.dart';

import 'Activities/Acceuil.dart';
import 'Activities/Login.dart';

void main() {
  runApp(MyApp());
}

//APPLICATION

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TodoApp",
      theme: ThemeData(fontFamily: "Poppins"),

      localizationsDelegates: [
        DemoDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
      ],



      initialRoute: "/screen1",
      routes: <String, WidgetBuilder>{
        "/screen1": (BuildContext context) => new LoginScreen(),
        "/screen2": (BuildContext context) => new Acceuil(),
        "/screen3": (BuildContext context) => new AddTask(),
        //"/screen4": (BuildContext context) => new Consultation(id:null),
      },
    );
  }
}