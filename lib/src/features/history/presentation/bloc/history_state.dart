part of 'history_bloc.dart';

class HistoryState {
  final bool isLoading;
  final List<History> items;
  final String? error;

  const HistoryState({
    this.isLoading = false,
    this.items = const [],
    this.error,
  });

  HistoryState copyWith({
    bool? isLoading,
    List<History>? items,
    String? error,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      error: error,
    );
  }
}