import 'package:dio/dio.dart';

import '../dtos/auth_response_dto.dart';

class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<AuthResponseDto> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    final resp = await _dio.post(
      '/api/Auth/signup',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phone': phone,
      },
    );
    return AuthResponseDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    final resp = await _dio.post(
      '/api/Auth/signin',
      data: {'email': email, 'password': password},
    );
    return AuthResponseDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<AuthResponseDto> refresh(String refreshToken) async {
    final resp = await _dio.post(
      '/api/Auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );
    return AuthResponseDto.fromJson(resp.data as Map<String, dynamic>);
  }

  Future<void> logout(String refreshToken) async {
    await _dio.post('/api/Auth/logout', data: {'refreshToken': refreshToken});
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post('/api/Auth/forgot-password', data: {'email': email});
  }

  Future<void> verifyResetCode({
    required String email,
    required String resetCode,
  }) async {
    await _dio.post(
      '/api/Auth/verify-code',
      data: {'email': email, 'resetCode': resetCode},
    );
  }

  Future<void> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _dio.post(
      '/api/Auth/reset-password',
      data: {
        'email': email,
        'resetCode': resetCode,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      },
    );
  }
}
