import 'dart:developer';

import 'package:device_vitals/src/core/network/exceptions/exceptions.dart';
import 'package:device_vitals/src/core/utils/device_utils.dart';
import 'package:device_vitals/src/features/history/domain/entities/analytics_data_entity.dart';
import 'package:device_vitals/src/features/history/domain/entities/history_entity.dart';
import 'package:device_vitals/src/features/history/domain/usecases/get_analytics.dart';
import 'package:device_vitals/src/features/history/domain/usecases/get_history.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistory getHistory;
  final GetAnalytics getAnalytics;

  HistoryBloc({required this.getHistory, required this.getAnalytics}) : super(const HistoryState()) {
    on<LoadHistory>(_onLoadHistory);
    on<LoadAnalytics>(_onLoadAnalytics);
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final history = await getHistory();

      emit(state.copyWith(isLoading: false, items: history));
    } on ApplicationException catch (e) {
      emit(state.copyWith(isLoading: false, error: () => e.message));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: () => "Unknown error occurred"));
    }
  }

  Future<void> _onLoadAnalytics(LoadAnalytics event, Emitter<HistoryState> emit) async {
    log("........._____........");
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final deviceId = await DeviceUtils.getDeviceId();
      final analytics = await getAnalytics(deviceId: deviceId);
      emit(state.copyWith(isLoading: false, analytics: analytics));
    } on ApplicationException catch (e) {
      emit(state.copyWith(isLoading: false, error: () => e.message));
    } catch (e, s) {
      emit(state.copyWith(isLoading: false, error: () => "Unknown error occurred"));
    }
  }
}
