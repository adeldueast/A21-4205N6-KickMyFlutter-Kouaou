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
  var response =
      await SingletonDio.getDio().get('http://exercices-web.herokuapp.com/exos/cookie/echo');
  print(response);
  return response.data;
}

Future<SignupResponse> signup(SignupRequest request) async {
  try {
    var dio = Dio();
    var response = await SingletonDio.getDio().post(
        'http://kickmyb-server.herokuapp.com/api/id/signup',
        data: request);
    print(response);
    return SignupResponse.fromJson(response.data);
  } catch (e) {
    print(e);
    throw (e);
  }
}