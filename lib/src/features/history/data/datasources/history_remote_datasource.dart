import 'package:device_vitals/src/core/base/base_remote_datasource.dart';
import 'package:device_vitals/src/core/constants/app_strings.dart';
import 'package:device_vitals/src/features/history/data/models/analytics_data_response.dart';
import 'package:device_vitals/src/features/history/data/models/history_response.dart';

class HistoryRemoteDataSource extends BaseRemoteDatasource {
  Future<HistoryResponse> fetchHistory() async {
    final endpoint = "$baseUrl${AppStrings.urlGetHistory}";
    final api = dioClient.get(endpoint);
    final response = await callApi(api);
    final json = response.data;
    logger.d(json);
    return HistoryResponse.fromJson(json);
  }

  Future<AnalyticsDataResponse> fetchAnalyticsData({required String deviceId}) async {
    final endpoint = "$baseUrl${AppStrings.urlGetAnalytics}";
    final api = dioClient.get(endpoint, queryParameters: {"device_id": deviceId});
    final response = await callApi(api);
    final json = response.data;
    logger.d(json);
    return AnalyticsDataResponse.fromJson(json);
  }
}
