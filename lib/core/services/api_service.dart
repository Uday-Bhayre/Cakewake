import 'package:cakewake_vendor/core/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class ApiService {
  final dio.Dio _dio;
  final String baseUrl = 'https://cakewake-9huv.onrender.com/api/v1';

  ApiService() : _dio = dio.Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);

    // Add interceptors for auth tokens, logging etc
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) {
          // Insert token if available
          final token = AuthService.to.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          print('Making request to ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print('Received response: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          print('Request error: ${error.message}');
          if (error.response != null) {
            print('Server response: ${error.response?.data}');
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<dio.Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(path, queryParameters: params);
    } on dio.DioException catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch data: ${e.message}',
        snackPosition: SnackPosition.BOTTOM,
      );
      throw _handleError(e);
    }
  }

  Future<dio.Response> post(
    String path, {
    dynamic data,
    dio.Options? options,
  }) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on dio.DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dio.DioException error) {
    Get.snackbar(
      'Error',
      error.response?.data?['error'] ?? error.response?.data?['message'] ?? 'An unexpected error occurred. Please try again later.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    if (error.response != null && error.response!.data != null) {
      // If server sent a response with error details
      final serverError = error.response!.data;
      if (serverError is Map<String, dynamic> &&
          serverError['message'] != null) {
        return Exception(serverError['message']);
      }
    }

    switch (error.type) {
      case dio.DioExceptionType.connectionTimeout:
        return Exception(
          'Connection timeout - please check your internet connection and try again',
        );
      case dio.DioExceptionType.sendTimeout:
        return Exception('Request timeout - please try again');
      case dio.DioExceptionType.receiveTimeout:
        return Exception('Server response timeout - please try again');
      case dio.DioExceptionType.badResponse:
        return Exception(
          'Server error: ${error.response?.statusCode} - ${error.message}',
        );
      case dio.DioExceptionType.connectionError:
        return Exception(
          'No internet connection - please check your connection and try again',
        );
      default:
        return Exception('Network error: ${error.message}');
    }
  }
}
