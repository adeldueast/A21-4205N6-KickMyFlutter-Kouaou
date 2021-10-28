

import 'dart:io';

class SessionSingleton {

  //Singleton
  static final SessionSingleton _singleton = SessionSingleton._internal();
  factory SessionSingleton() => _singleton;
  SessionSingleton._internal();

  //getter
  static SessionSingleton get shared => _singleton;

  Cookie? cookie;
  String? username;
  String? password;

}

