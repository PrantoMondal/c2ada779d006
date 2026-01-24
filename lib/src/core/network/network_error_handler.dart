import 'dart:io';
import 'package:device_vitals/src/core/network/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

Exception handleNetworkError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return ApplicationException(message: "Connection was cancelled.");

    case DioExceptionType.connectionTimeout:
      return ApplicationException(message: "Failed to establish a connection.");

    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.connectionError:
      return TimeoutException(message: "Connection timed out.");

    case DioExceptionType.unknown:
      return NetworkException(message: "No internet connection.");

    case DioExceptionType.badCertificate:
      return ApplicationException(message: "Invalid SSL certificate.");

    case DioExceptionType.badResponse:
      return _parseNetworkErrorResponse(dioError);

    default:
      return ApplicationException(message: "An unknown error occurred.");
  }
}

Exception _parseNetworkErrorResponse(DioException dioError) {
  int statusCode = dioError.response?.statusCode ?? -1;
  int? status;
  String? serverMessage;

  try {
    status = dioError.response?.data["status"];
    final errors = dioError.response?.data["errors"];

    if (errors is Map && errors.isNotEmpty) {
      serverMessage = (errors.values.first as List).first.toString();
    } else {
      serverMessage =
          dioError.response?.data["message"]?.toString() ??
          dioError.response?.data["error"]?.toString() ??
          "Something went wrong on the server.";
    }
  } catch (_) {
    serverMessage = "Something went wrong on the server.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException(
        message: "Service is temporarily unavailable.",
        status: status!.toString(),
      );

    case HttpStatus.notFound:
      return NotFoundException(message: serverMessage, status: status!.toString());

    case HttpStatus.unauthorized:
      return UnauthorizedException(message: serverMessage, status: status!.toString());

    default:
      return ApiException(
        httpCode: statusCode,
        status: status!.toString(),
        message: serverMessage ?? "Something went wrong.",
      );
  }
}
