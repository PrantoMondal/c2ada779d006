part of 'history_bloc.dart';

class HistoryState {
  final bool isLoading;
  final List<HistoryEntity> items;
  final String? error;

  const HistoryState({this.isLoading = false, this.items = const [], this.error});

  HistoryState copyWith({bool? isLoading, List<HistoryEntity>? items, String? error}) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
  }
}
