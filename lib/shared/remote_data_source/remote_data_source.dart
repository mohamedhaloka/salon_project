import 'dart:developer';

import 'package:dio/dio.dart';

class DioHelper {
  static var dio = Dio(
    // https://www.salon.spider-te8.com/
    BaseOptions(
        baseUrl: 'https://www.salon.spider-te8.com/',
        receiveDataWhenStatusError: true),
  );

  static Future<Response> postData(
      {required String path,
      required Map<String, dynamic> data,
      String? token}) {
    log(data.toString(), name: 'DATA');
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return dio.post(path, data: data);
  }

  static Future<Response> putData(
      {required String path,
      required Map<String, dynamic> data,
      required String? token}) {
    dio.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    return dio.put(path, data: data);
  }

  static Future<Response> getData(
      {required String path, String? token, Map<String, dynamic>? data}) async {
    dio.options.headers = {
      'lang': 'en',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return await dio.get(
      path,
      queryParameters: data,
    );
  }
}
