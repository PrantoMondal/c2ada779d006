import 'package:device_vitals/src/features/home/domain/usecases/get_device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDeviceInfo getDeviceInfo;

  HomeBloc({required this.getDeviceInfo}) : super(const HomeState()) {
    on<LoadHomeData>(_onLoadHomeData);
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
}
