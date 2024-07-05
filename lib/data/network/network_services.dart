import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters});
  Future<Response<dynamic>> post(String url, {Map<String, dynamic>? data});
  Future<Response<dynamic>> put(String url, {Map<String, dynamic>? data});
  Future<Response<dynamic>> delete(String url, {Map<String, dynamic>? data});
}
