import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class WebFunctions {
  final Dio _dio = Dio();
  PersistCookieJar persistentCookies;
  final String _url = 'https://test.maxcrowdfund.com/en/api';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<Directory> get _localCoookieDirectory async {
    final path = await _localPath;
    final Directory dir = Directory('$path/cookies');
    await dir.create();
    return dir;
  }

  Future<Response> getLoginResponse({
    @required Map<String, dynamic> body,
  }) async {
    try {
      Response res;
      final Directory dir = await _localCoookieDirectory;
      final cookiePath = dir.path;
      persistentCookies = PersistCookieJar(dir: '$cookiePath');
      persistentCookies.deleteAll();
      _dio.interceptors.add(
        CookieManager(
          persistentCookies,
        ),
      );
      _dio.options = BaseOptions(
        baseUrl: _url,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        connectTimeout: 5000,
        receiveTimeout: 100000,
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'Connection': 'keep-alive',
        },
      );
      _dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response) {
            persistentCookies.loadForRequest(
              Uri.parse(_url),
            );
            res = response;
            return response;
          },
        ),
      );
      await _dio.post('/user/login?_format=json', data: body);
      return res;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return null;
    }
  }

  Future<Response> getBalance() async {
    try {
      Response res;
      final Directory dir = await _localCoookieDirectory;
      final cookiePath = dir.path;
      persistentCookies = PersistCookieJar(dir: '$cookiePath');
      _dio.interceptors.add(
        CookieManager(
          persistentCookies,
        ),
      );
      _dio.options = BaseOptions(
        baseUrl: _url,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        connectTimeout: 5000,
        receiveTimeout: 100000,
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'Connection': 'keep-alive',
        },
      );
      _dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response) {
            persistentCookies.loadForRequest(
              Uri.parse(_url),
            );
            res = response;
            return response;
          },
        ),
      );
      await _dio.get('/account-balance?_format=json');
      return res;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return null;
    }
  }

  Future<Response> logout({@required String logoutToken}) async {
    try {
      Response res;
      final Directory dir = await _localCoookieDirectory;
      final cookiePath = dir.path;
      persistentCookies = PersistCookieJar(dir: '$cookiePath');
      _dio.interceptors.add(
        CookieManager(
          persistentCookies,
        ),
      );
      _dio.options = BaseOptions(
        baseUrl: _url,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        connectTimeout: 5000,
        receiveTimeout: 100000,
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'Connection': 'keep-alive',
        },
      );
      _dio.interceptors.add(
        InterceptorsWrapper(
          onResponse: (Response response) {
            res = response;
            return response;
          },
        ),
      );
      await _dio.post('/user/logout?_format=json&token=$logoutToken');
      return res;
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return null;
    }
  }

  deleteCookies() {
    persistentCookies.deleteAll();
  }
}
