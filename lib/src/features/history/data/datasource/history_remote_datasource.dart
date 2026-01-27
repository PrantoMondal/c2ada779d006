import 'package:device_vitals/src/core/base/base_remote_datasource.dart';
import 'package:dio/dio.dart';

class HistoryRemoteDataSource extends BaseRemoteDatasource {
  Future<List<Map<String, dynamic>>> fetchHistory() async {
    logger.d("fetchHistory");
    final Response response = await callApi(
      dioClient.get(
        '$baseUrl/vitals',
      ),
    );
    logger.d("ajsdhagjsdgasjd${response.data}");

    // assuming API response shape:
    // {
    //   "data": [ { ... }, { ... } ]
    // }

    final List list = response.data['data'] as List;

    return list.cast<Map<String, dynamic>>();
  }
}
