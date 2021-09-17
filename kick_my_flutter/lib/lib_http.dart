import 'package:dio/dio.dart';
import 'package:kick_my_flutter/transfer.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class SingletonDio {
  static var cookieManager = CookieManager(CookieJar());

  static Dio getDio() {
    Dio dio = Dio();
    dio.interceptors.add(cookieManager);
    return dio;
  }
}

Future<String> cookie() async {
  var response = await SingletonDio.getDio()
      .get('http://exercices-web.herokuapp.com/exos/cookie/echo');
  print(response);
  return response.data;
}

Future<SignupResponse> signup(SignupRequest request) async {
  var response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signup',
      data: request);
  print(response);
  print(response.statusCode.toString() + "logged in");
  return SignupResponse.fromJson(response.data);
}

Future<SigninResponse> signin(SigninRequest request) async {
  var response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signin',
      data: request);
  print(response);
  print(response.statusCode.toString() + "signed in");
  return SigninResponse.fromJson(response.data);
}

addTask(AddTaskRequest request) async {
  var response = await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/add', data: request);
  print(response);
  print(response.statusCode.toString() + "added a task successfully");
}


logout() async {
  var response = await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/id/signout');
  print(response);
  print(response.statusCode.toString() + "logged out successfully");
}
