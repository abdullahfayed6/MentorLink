import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/failure.dart';
import '../data/repositories/auth_repository.dart';

part 'auth_cubit.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({int? traineeId}) = _Authenticated;
  const factory AuthState.loggedOut() = _LoggedOut;
  const factory AuthState.failure(Failure failure) = _Failure;
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repo;
  AuthCubit(this._repo) : super(const AuthState.initial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
  }) async {
    emit(const AuthState.loading());
    final res = await _repo.register(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      phone: phone,
    );
    res.fold(
      (l) => emit(AuthState.failure(l)),
      (r) => emit(AuthState.authenticated(traineeId: r.user?.traineeId)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    final res = await _repo.login(email: email, password: password);
    res.fold(
      (l) => emit(AuthState.failure(l)),
      (r) => emit(AuthState.authenticated(traineeId: r.user?.traineeId)),
    );
  }

  Future<void> logout() async {
    emit(const AuthState.loading());
    final res = await _repo.logout();
    res.fold(
      (l) => emit(AuthState.failure(l)),
      (r) => emit(const AuthState.loggedOut()),
    );
  }
}
