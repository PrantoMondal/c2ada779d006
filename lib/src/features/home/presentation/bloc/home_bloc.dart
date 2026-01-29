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

    emit(state.copyWith(
      status: HomeStatus.loading,
      isRefreshing: event.isRefresh,
      errorMessage: () => null,
      logSuccessMessage: () => null,
    ));

    try {
      final data = await getDeviceInfo();

      emit(
        state.copyWith(
          status: HomeStatus.success,
          deviceData: data,
          lastUpdated: DateTime.now(),
          errorMessage: () => null,
          logSuccessMessage: () => null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorMessage: () => e.toString(),
        logSuccessMessage: () => null,
      ));
    }
  }

  Future<void> _onLogVitals(LogVitals event, Emitter<HomeState> emit) async {
    if (state.deviceData == null || state.isLogging) return;

    emit(state.copyWith(
      isLogging: true,
      errorMessage: () => null,
      logSuccessMessage: () => null,
    ));

    try {
      final deviceId = await DeviceUtils.getDeviceId();

      final params = InfoParams(
        deviceId: deviceId,
        timestamp: '${state.lastUpdated!.toUtc().toIso8601String().split('.').first}Z',
        thermalValue: state.deviceData!.thermalStatus,
        batteryLevel: state.deviceData!.batteryLevel.toDouble(),
        memoryUsage: state.deviceData!.memoryUsagePercentage,
      );

      final message = await logStatus(params: params);
      emit(state.copyWith(
        isLogging: false,
        logSuccessMessage: () => message,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          isLogging: false,
          errorMessage: () => "Failed to log status: ${e.toString()}",
        ),
      );
    }
  }
}