import 'package:dio/dio.dart';

import '../../features/authentication/data/dtos/token_dto.dart';
import 'token_storage.dart';

class TokenRefresher {
  final Dio _dio;
  final TokenStorage _storage;
  TokenRefresher(this._dio, this._storage);

  Future<String> refresh(String refreshToken) async {
    final resp = await _dio.post(
      '/api/Auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );
    final data = resp.data as Map<String, dynamic>;
    final token = TokenDto.fromJson(
      (data['token'] ?? data) as Map<String, dynamic>,
    );
    await _storage.saveTokens(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );
    return token.accessToken;
  }
}
