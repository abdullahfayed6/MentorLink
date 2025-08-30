import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';

  final SharedPreferences _sp;
  TokenStorage(this._sp);

  String? get accessToken => _sp.getString(_kAccessToken);
  String? get refreshToken => _sp.getString(_kRefreshToken);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _sp.setString(_kAccessToken, accessToken);
    await _sp.setString(_kRefreshToken, refreshToken);
  }

  Future<void> clear() async {
    await _sp.remove(_kAccessToken);
    await _sp.remove(_kRefreshToken);
  }
}
