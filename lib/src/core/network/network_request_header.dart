import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RequestHeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['content-type'] = 'application/json';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      if (kDebugMode) {
        print("Unauthorized request: ${err.requestOptions.uri}");
      }
    } else if (err.response?.statusCode == 500) {
      if (kDebugMode) {
        print("Server error: ${err.requestOptions.uri}");
      }
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print("Response: ${response.statusCode} ${response.requestOptions.uri}");
    }
    super.onResponse(response, handler);
  }
}
