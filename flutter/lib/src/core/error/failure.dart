// A lightweight Failure hierarchy without freezed.
// Keeps the same API used across the app: Failure.network(), .server(), .unauthorized(), .validation(), .unknown().

abstract class Failure {
  final String? message;
  const Failure({this.message});

  // Helpers to preserve previous API
  factory Failure.network({String? message, int? statusCode}) =>
      NetworkFailure(message: message, statusCode: statusCode);

  factory Failure.server({String? message, int? statusCode, Object? data}) =>
      ServerFailure(message: message, statusCode: statusCode, data: data);

  factory Failure.unauthorized({String? message}) =>
      UnauthorizedFailure(message: message);

  factory Failure.validation({String? message, Map<String, dynamic>? errors}) =>
      ValidationFailure(message: message, errors: errors);

  factory Failure.unknown({
    String? message,
    Object? error,
    StackTrace? stackTrace,
  }) => UnknownFailure(message: message, error: error, stackTrace: stackTrace);

  @override
  String toString() => message ?? runtimeType.toString();
}

class NetworkFailure extends Failure {
  final int? statusCode;
  const NetworkFailure({super.message, this.statusCode});
}

class ServerFailure extends Failure {
  final int? statusCode;
  final Object? data;
  const ServerFailure({super.message, this.statusCode, this.data});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({super.message});
}

class ValidationFailure extends Failure {
  final Map<String, dynamic>? errors;
  const ValidationFailure({super.message, this.errors});
}

class UnknownFailure extends Failure {
  final Object? error;
  final StackTrace? stackTrace;
  const UnknownFailure({super.message, this.error, this.stackTrace});
}
