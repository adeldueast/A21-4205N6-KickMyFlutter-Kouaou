import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kick_my_flutter/Models/SessionSingleton.dart';
import 'package:kick_my_flutter/Models/transfer.dart';
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

// je sais pas pk jai mis sa ici lol
Future<String> cookie() async {
  var response = await SingletonDio.getDio()
      .get('http://exercices-web.herokuapp.com/exos/cookie/echo');
  print(response);
  return response.data;
}

Future<SignupResponse> signup(SignupRequest request) async {
  var response = await SingletonDio.getDio()
      .post('http://10.0.2.2:8080/api/id/signup', data: request);

  print(response);
  if (response.statusCode == 200)
    print(response.statusCode.toString() + " logged in success");
    List<Cookie> cookies = await SingletonDio.cookieManager.cookieJar.loadForRequest(Uri.parse("http://10.0.2.2:8080/api/id/signup"));
    SessionSingleton.shared.cookie = cookies.first;


  return SignupResponse.fromJson(response.data);
}

Future<SigninResponse> signin(SigninRequest request) async {
  var response = await SingletonDio.getDio()
      .post('http://10.0.2.2:8080/api/id/signin', data: request);
  print(response);
  if (response.statusCode == 200)
    print(response.statusCode.toString() + " signin success");
    List<Cookie> cookies = await SingletonDio.cookieManager.cookieJar.loadForRequest(Uri.parse("http://10.0.2.2:8080/api/id/signin"));
    SessionSingleton.shared.cookie = cookies.first;
  return SigninResponse.fromJson(response.data);
}

addTask(AddTaskRequest request) async {
  var response = await SingletonDio.getDio()
      .post('http://10.0.2.2:8080/api/add', data: request);
  print(response);
  print(response.statusCode.toString() + " added a task successfully");
}

logout() async {
  var response =
      await SingletonDio.getDio().post('http://10.0.2.2:8080/api/id/signout');
  print(response);
  print(response.statusCode.toString() + " logged out successfully");
}

Future<List<HomeItemResponse>> getListTask() async {
  var response =
      await SingletonDio.getDio().get('http://10.0.2.2:8080/api/home');
  if (response.statusCode == 200)
    print(response.statusCode.toString() + " getListTask success");

  var listeJSON = response.data as List;

  List<HomeItemResponse> _listTask = [];
  _listTask = listeJSON.map((e) {
    return HomeItemResponse.fromJson(e);
  }).toList();

  return _listTask;
}

Future<TaskDetailResponse> getTaskDetail(int id) async {
  var response = await SingletonDio.getDio()
      .get('http://10.0.2.2:8080/api/detail/' + id.toString());
  if (response.statusCode == 200)
    print(response.statusCode.toString() + " getTaskDetail success");

  return TaskDetailResponse.fromJson(response.data);
}

Future<String> updateTaskPourcentage(int id, int valeur) async {
  var response = await SingletonDio.getDio()
      .get("http://10.0.2.2:8080/api/progress/$id/$valeur");

  if (response.statusCode == 200)
    print(response.statusCode.toString() + " updated task value success");
  return response.data;
}

//http://localhost:8080/api/singleFile/

Future<String> addImageToTask(FormData formData) async {
  try {
    var response = await SingletonDio.getDio()
        .post("http://10.0.2.2:8080/file", data: formData);

    if (response.statusCode == 200)
      print(response.statusCode.toString() +
          "Added picture to task " +
          formData.fields.first.value);
    return response.data;
  } on DioError catch (e) {
    print(e.response!.statusCode);
    print(e.message);
    print(e.response);
    return e.response!.data.toString();
  }
}
