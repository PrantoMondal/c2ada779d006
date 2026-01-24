import 'dart:io';
import 'package:dio/dio.dart';
import 'package:device_vitals/src/core/config/build_config.dart';
import 'package:device_vitals/src/core/network/dio_network_provider.dart';
import 'package:device_vitals/src/core/network/network_error_handler.dart';
import 'package:device_vitals/src/core/network/exceptions/exceptions.dart';

abstract class BaseRemoteDatasource {
  final String baseUrl = BuildConfig.instance.envConfig.baseUrl;

  Dio get dioClient => NetworkProvider.dioWithHeaderToken;

  final logger = BuildConfig.instance.envConfig.logger;

  /// Makes an API request and handles errors consistently
  Future<Response<T>> callApi<T>(Future<Response<T>> api) async {
    try {
      // Perform API request
      final Response<T> response = await api;

      // Log the response
      logger.i(
        "API Response >>>>>>>\n"
        "URL: ${response.requestOptions.uri}\n"
        "Method: ${response.requestOptions.method}\n"
        "Headers: ${response.requestOptions.headers}\n"
        "Request Data: ${response.requestOptions.data}\n"
        "Status: ${response.statusCode}\n"
        "Response: ${response.data}",
      );

      // Check HTTP status
      if (response.statusCode != HttpStatus.ok) {
        final message = response.data is Map<String, dynamic>
            ? (response.data as Map<String, dynamic>)["msg"] ?? "Unknown error"
            : "Unknown error";
        logger.w("API returned non-OK status: $message");
        throw ApiException(
          httpCode: response.statusCode ?? -1,
          message: message,
          status: '',
        );
      }

      return response;
    } on DioException catch (dioError) {
      logger.e(
        "API Error >>>>>>>\n"
        "URL: ${dioError.requestOptions.uri}\n"
        "Method: ${dioError.requestOptions.method}\n"
        "Headers: ${dioError.requestOptions.headers}\n"
        "Request Data: ${dioError.requestOptions.data}\n"
        "Status: ${dioError.response?.statusCode}\n"
        "Response: ${dioError.response?.data}\n"
        "Message: ${dioError.message}",
      );

      final exception = handleNetworkError(dioError);
      throw exception;
    } catch (error) {
      logger.e("Unexpected error: $error");

      if (error is BaseException) {
        rethrow;
      }

      throw ApplicationException(message: error.toString());
    }
  }
}
