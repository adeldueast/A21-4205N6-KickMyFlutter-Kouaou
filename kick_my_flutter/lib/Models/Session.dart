import 'package:flutter/material.dart';

class Session {

  //Singleton
  static final Session _singleton = Session._internal();
  factory Session() => _singleton;
  Session._internal();

  //getter
  static Session get shared => _singleton;

  String? username;
  String? password;

}

