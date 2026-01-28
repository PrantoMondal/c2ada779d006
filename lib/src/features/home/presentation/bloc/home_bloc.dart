import 'package:device_vitals/src/core/utils/device_utils.dart';
import 'package:device_vitals/src/features/home/data/models/info_params.dart';
import 'package:device_vitals/src/features/home/domain/entities/device_info_entity.dart';
import 'package:device_vitals/src/features/home/domain/usecases/get_device_info.dart';
import 'package:device_vitals/src/features/home/domain/usecases/log_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDeviceInfo getDeviceInfo;
  final LogStatus logStatus;

  HomeBloc({required this.getDeviceInfo, required this.logStatus})
    : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<LogVitals>(_onLogVitals);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    if (state.isLoading) return;

    emit(state.copyWith(status: HomeStatus.loading, isRefreshing: event.isRefresh));

    try {
      final data = await getDeviceInfo();

      emit(
        state.copyWith(
          status: HomeStatus.success,
          deviceData: data,
          lastUpdated: DateTime.now(),
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onLogVitals(LogVitals event, Emitter<HomeState> emit) async {
    if (state.deviceData == null) {
      emit(state.copyWith(errorMessage: "No device data available to log"));
      return;
    }

    emit(state.copyWith(errorMessage: null));
    final deviceId = await DeviceUtils.getDeviceId();
    try {
      final params = InfoParams(
        deviceId: deviceId,
        timestamp: '${DateTime.now().toUtc().toIso8601String().split('.').first}Z',
        thermalValue: state.deviceData!.temperatureC,
        batteryLevel: state.deviceData!.batteryLevel.toDouble(),
        memoryUsage: state.deviceData!.memoryUsagePercentage,
      );

      final message = await logStatus(params: params);
    } catch (e) {
      emit(state.copyWith(errorMessage: "Failed to log status: ${e.toString()}"));
    }
  }
}
