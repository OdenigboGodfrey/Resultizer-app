import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:resultizer_merged/core/error/response_status.dart';

class Failure extends Equatable {
  final int code;
  final String message;

  const Failure({required this.code, required this.message});

  @override
  List<Object?> get props => [code, message];
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = const Failure(code: 00, message: 'unexpected');
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return const Failure(code: 00, message: 'networkConnectError');
    case DioErrorType.response:
      switch (error.response?.statusCode) {
        case ResponseStatusCode.internalServerError:
          return const Failure(code: 01, message: 'internalServerError');
        case ResponseStatusCode.clientClosedRequest:
          return const Failure(code: 02, message: 'clientClosedRequest');
        default:
          return const Failure(code: 03, message: 'unexpected');
      }
    case DioErrorType.cancel:
    case DioErrorType.other:
      return const Failure(code: 04, message: 'unexpected');
  }
}


