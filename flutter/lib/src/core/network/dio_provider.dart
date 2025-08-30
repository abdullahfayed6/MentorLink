import 'package:dio/dio.dart';

import 'api_config.dart';
import 'token_refresher.dart';
import 'token_storage.dart';

Dio buildDio(ApiConfig config, TokenStorage tokenStorage) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Log requests/responses to ease debugging of 400 errors
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
      logPrint: (obj) => print(obj),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = tokenStorage.accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        final refreshToken = tokenStorage.refreshToken;
        final requestOptions = error.requestOptions;

        final isUnauthorized = error.response?.statusCode == 401;
        final isAuthEndpoint =
            requestOptions.path.contains('/api/Auth/refresh-token') ||
            requestOptions.path.contains('/api/Auth/signin') ||
            requestOptions.path.contains('/api/Auth/signup');

        if (isUnauthorized && refreshToken != null && !isAuthEndpoint) {
          try {
            final refresher = TokenRefresher(
              Dio(BaseOptions(baseUrl: config.baseUrl)),
              tokenStorage,
            );
            final newAccess = await refresher.refresh(refreshToken);
            final opts = Options(
              method: requestOptions.method,
              headers: Map<String, dynamic>.from(requestOptions.headers)
                ..['Authorization'] = 'Bearer $newAccess',
            );
            final response = await dio.request(
              requestOptions.path,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
              options: opts,
            );
            return handler.resolve(response);
          } catch (_) {
            // Give up and propagate original error
          }
        }
        handler.next(error);
      },
    ),
  );

  return dio;
}
