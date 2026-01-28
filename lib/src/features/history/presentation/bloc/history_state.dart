part of 'history_bloc.dart';

class HistoryState {
  final bool isLoading;
  final List<HistoryEntity> items;
  final AnalyticsDataEntity? analytics;
  final String? error;

  const HistoryState({
    this.isLoading = false,
    this.items = const [],
    this.analytics,
    this.error,
  });

  HistoryState copyWith({
    bool? isLoading,
    List<HistoryEntity>? items,
    AnalyticsDataEntity? analytics,
    String? error,
  }) {
    return HistoryState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
      analytics: analytics ?? this.analytics,
      error: error,
    );
  }
}
