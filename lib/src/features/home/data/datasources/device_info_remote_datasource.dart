import 'package:device_vitals/src/core/base/base_remote_datasource.dart';
import 'package:device_vitals/src/core/constants/app_strings.dart';
import 'package:device_vitals/src/features/history/data/models/history_response.dart';
import 'package:device_vitals/src/features/home/data/models/info_params.dart';

class DeviceInfoRemoteDatasource extends BaseRemoteDatasource {
  Future<String> logStatus({required InfoParams params}) async {
    final endpoint = "$baseUrl${AppStrings.urlLogVitals}";
    final api = dioClient.post(endpoint, data: params.toJson());
    final response = await callApi(api);
    final json = response.data;
    logger.d(json);
    return json["message"];
  }
}
