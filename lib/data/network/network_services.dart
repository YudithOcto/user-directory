import 'package:dio/dio.dart';

abstract class NetworkService {
  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? queryParameters});
  Future<Response<T>> post<T>(String url, {dynamic data});
  Future<Response<T>> put<T>(String url, {dynamic data});
  Future<Response<T>> delete<T>(String url, {dynamic data});
}
