import 'package:dio/dio.dart';
import 'package:kick_my_flutter/Models/Task.dart';
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
  if(response.statusCode==200)  print(response.statusCode.toString() + " logged in success");

  return SignupResponse.fromJson(response.data);
}

Future<SigninResponse> signin(SigninRequest request) async {
  var response = await SingletonDio.getDio().post(
      'https://kickmyb-server.herokuapp.com/api/id/signin',
      data: request);
  print(response);
  if(response.statusCode==200)  print(response.statusCode.toString() + " signin success");

  return SigninResponse.fromJson(response.data);
}

addTask(AddTaskRequest request) async {
  var response = await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/add', data: request);
  print(response);
  print(response.statusCode.toString() + " added a task successfully");
}

logout() async {
  var response = await SingletonDio.getDio()
      .post('https://kickmyb-server.herokuapp.com/api/id/signout');
  print(response);
  print(response.statusCode.toString() + " logged out successfully");
}

Future<List<HomeItemResponse>> getListTask() async {
  var response = await SingletonDio.getDio()
      .get('https://kickmyb-server.herokuapp.com/api/home');
  if(response.statusCode==200)  print(response.statusCode.toString() + " getListTask success");


  var listeJSON = response.data as List;

  List<HomeItemResponse> _listTask = [];
  _listTask = listeJSON.map((e) {
    return HomeItemResponse.fromJson(e);
  }).toList();

  return _listTask;
}

Future<TaskDetailResponse> getTaskDetail(int id) async {
  var response = await SingletonDio.getDio()
      .get('https://kickmyb-server.herokuapp.com/api/detail/' + id.toString());
  if(response.statusCode==200)  print(response.statusCode.toString() + " getTaskDetail success");

  return TaskDetailResponse.fromJson(response.data);
}

Future<String> updateTaskPourcentage(int id , int valeur) async {

  var response = await SingletonDio.getDio()
      .get("https://kickmyb-server.herokuapp.com/api/progress/$id/$valeur");

  if(response.statusCode==200)  print(response.statusCode.toString() + " updated task value success");
  return response.data;
}
