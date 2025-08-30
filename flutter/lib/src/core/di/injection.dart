import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/authentication/application/auth_cubit.dart';
import '../../features/authentication/application/forgot_password_cubit.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/data/repositories/auth_repository.dart';
import '../network/api_config.dart';
import '../network/dio_provider.dart' as net;
import '../network/token_refresher.dart';
import '../network/token_storage.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies({String? baseUrl}) async {
  // SharedPreferences
  final sp = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sp);
  // Token storage
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(sp));

  // Base url config
  getIt.registerSingleton<ApiConfig>(
    ApiConfig(baseUrl: baseUrl ?? ApiConfig.defaultBaseUrl),
  );

  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final config = getIt<ApiConfig>();
    final tokenStorage = getIt<TokenStorage>();
    return net.buildDio(config, tokenStorage);
  });

  // Token refresher uses a bare dio (no interceptors) to avoid recursion
  getIt.registerLazySingleton<TokenRefresher>(() {
    final config = getIt<ApiConfig>();
    final tokenStorage = getIt<TokenStorage>();
    final bare = Dio(BaseOptions(baseUrl: config.baseUrl));
    return TokenRefresher(bare, tokenStorage);
  });

  // Data source & repository
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthRemoteDataSource>(), getIt<TokenStorage>()),
  );

  // Cubits
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));
  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepository>()),
  );
}
