import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/error/failure.dart';
import '../data/repositories/auth_repository.dart';

part 'forgot_password_cubit.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.codeSent() = _CodeSent;
  const factory ForgotPasswordState.codeVerified() = _CodeVerified;
  const factory ForgotPasswordState.passwordReset() = _PasswordReset;
  const factory ForgotPasswordState.failure(Failure failure) = _Failure;
}

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _repo;
  ForgotPasswordCubit(this._repo) : super(const ForgotPasswordState.initial());

  Future<void> sendCode(String email) async {
    emit(const ForgotPasswordState.loading());
    final res = await _repo.forgotPassword(email);
    res.fold(
      (l) => emit(ForgotPasswordState.failure(l)),
      (r) => emit(const ForgotPasswordState.codeSent()),
    );
  }

  Future<void> verifyCode({
    required String email,
    required String resetCode,
  }) async {
    emit(const ForgotPasswordState.loading());
    final res = await _repo.verifyResetCode(email: email, resetCode: resetCode);
    res.fold(
      (l) => emit(ForgotPasswordState.failure(l)),
      (r) => emit(const ForgotPasswordState.codeVerified()),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String resetCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(const ForgotPasswordState.loading());
    final res = await _repo.resetPassword(
      email: email,
      resetCode: resetCode,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    res.fold(
      (l) => emit(ForgotPasswordState.failure(l)),
      (r) => emit(const ForgotPasswordState.passwordReset()),
    );
  }
}
