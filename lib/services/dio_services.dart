import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:user_directory/common/constants.dart';
import 'package:user_directory/common/extensions.dart';
import 'package:user_directory/data/local/storage_service.dart';
import 'package:user_directory/data/network/network_services.dart';

class DioService implements NetworkService {
  final Dio _dio;
  final StorageService storageService;

  DioService(this._dio, this.storageService) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await storageService.getData(Constants.bearerToken);
        debugPrint(token);
        if (token.isNotNullOrEmpty) {
          options.headers["Accept"] = "application/json";
          options.headers["Authorization"] = "Bearer $token";
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response);
      },
      onError: (DioException error, handler) {
        return handler.next(error);
      },
    ));
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> post<T>(String url, {data}) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> put<T>(String url, {data}) async {
    try {
      final response = await _dio.put(url, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response<T>> delete<T>(String url, {data}) async {
    try {
      final response = await _dio.delete(url);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
