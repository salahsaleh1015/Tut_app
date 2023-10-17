import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/application/costants.dart';

const String applicationJson = 'application/json';
const String contentType = "content-type";
const String authorization = "authorization";
const String accept = "accept";
const String defaultLanguage = "language";
int _timeOut = 60 * 1000;

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();

    Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: "send token here",
      defaultLanguage: "en" // todo get language from shared pref
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      connectTimeout: Duration(milliseconds: _timeOut),
      receiveTimeout: Duration(milliseconds: _timeOut),
    );


    if(!kReleaseMode){
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true));
    }


    return dio;
  }
}
