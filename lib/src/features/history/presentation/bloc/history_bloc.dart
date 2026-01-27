import 'package:bloc/bloc.dart';
import 'package:device_vitals/src/features/history/domain/model/history.dart';
import 'package:device_vitals/src/features/history/domain/usecases/get_history.dart';
import 'package:meta/meta.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistory getHistory;

  HistoryBloc({required this.getHistory})
      : super(const HistoryState()) {
    on<LoadHistory>(_onLoadHistory);
  }

  Future<void> _onLoadHistory(
      LoadHistory event,
      Emitter<HistoryState> emit,
      ) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final history = await getHistory(); // 👈 API CALL HERE

      emit(
        state.copyWith(
          isLoading: false,
          items: history,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: e.toString(),
        ),
      );
    }
  }
}