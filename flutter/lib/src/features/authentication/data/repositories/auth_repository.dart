import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/network/token_storage.dart';
import '../datasources/auth_remote_data_source.dart';
import '../dtos/auth_response_dto.dart';

class AuthRepository {
  final AuthRemoteDataSource _remote;
  final TokenStorage _storage;
  AuthRepository(this._remote, this._storage);

  String _extractMessage(Object? data, DioException e) {
    if (data is Map<String, dynamic>) {
      // 1) Aggregate model-state validation errors first
      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        final parts = <String>[];
        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            parts.add('${key.toString()}: ${value.first.toString()}');
          } else if (value is String) {
            parts.add('${key.toString()}: $value');
          }
        });
        if (parts.isNotEmpty) return parts.join('\n');
      }
      // 2) Then try message/detail/title
      final msg = (data['message'] ?? data['detail'] ?? data['title'])
          ?.toString();
      if (msg != null && msg.trim().isNotEmpty) return msg;
      // 3) Fallback: any string value
      if (data.values.any((v) => v is String)) {
        final firstStr = data.values.firstWhere((v) => v is String) as String;
        if (firstStr.trim().isNotEmpty) return firstStr;
      }
    } else if (data is String && data.trim().isNotEmpty) {
      return data;
    }
    return e.message ?? 'Request failed';
  }

  Failure _mapDio(Object e, StackTrace s) {
    if (e is DioException) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      final friendly = _extractMessage(data, e);
      if (status == 401) return Failure.unauthorized(message: friendly);
      if (status != null && status >= 500) {
        return Failure.server(
          message: friendly,
          statusCode: status,
          data: data,
        );
      }
      if (status != null && status >= 400) {
        return Failure.validation(
          message: friendly,
          errors: data is Map<String, dynamic> ? data : null,
        );
      }
      return Failure.network(message: friendly, statusCode: status);
    }
    return Failure.unknown(message: e.toString(), error: e, stackTrace: s);
  }

  Future<Either<Failure, AuthResponseDto>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    try {
      final res = await _remote.register(
        name: name,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phone: phone,
      );
      final token = res.token;
      if (token != null) {
        await _storage.saveTokens(
          accessToken: token.accessToken,
          refreshToken: token.refreshToken,
        );
      }
      return Right(res);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }

  Future<Either<Failure, AuthResponseDto>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await _remote.login(email: email, password: password);
      final token = res.token;
      if (token != null) {
        await _storage.saveTokens(
          accessToken: token.accessToken,
          refreshToken: token.refreshToken,
        );
      }
      return Right(res);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }

  Future<Either<Failure, Unit>> logout() async {
    try {
      final r = _storage.refreshToken;
      if (r != null) {
        await _remote.logout(r);
      }
      await _storage.clear();
      return const Right(unit);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }

  Future<Either<Failure, Unit>> forgotPassword(String email) async {
    try {
      await _remote.forgotPassword(email);
      return const Right(unit);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }

  Future<Either<Failure, Unit>> verifyResetCode({
    required String email,
    required String resetCode,
  }) async {
    try {
      await _remote.verifyResetCode(email: email, resetCode: resetCode);
      return const Right(unit);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _remote.resetPassword(
        email: email,
        resetCode: resetCode,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      return const Right(unit);
    } catch (e, s) {
      return Left(_mapDio(e, s));
    }
  }
}
