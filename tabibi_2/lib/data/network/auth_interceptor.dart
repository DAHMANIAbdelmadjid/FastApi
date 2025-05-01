import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the token from secure storage
    final token = await _storage.read(key: 'auth_token');

    // If token exists, add it to the headers
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Continue with the request
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 (Unauthorized) errors
    if (err.response?.statusCode == 401) {
      // Delete the stored token as it's invalid
      await _storage.delete(key: 'auth_token');

      // You could add token refresh logic here
      // For now, just propagate the error
    }

    // Continue with the error
    handler.next(err);
  }
}