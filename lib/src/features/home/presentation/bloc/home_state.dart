part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final Map<String, dynamic>? deviceData;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isRefreshing;

  const HomeState({
    this.status = HomeStatus.initial,
    this.deviceData,
    this.errorMessage,
    this.lastUpdated,
    this.isRefreshing = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    Map<String, dynamic>? deviceData,
    String? errorMessage,
    DateTime? lastUpdated,
    bool? isRefreshing,
  }) {
    return HomeState(
      status: status ?? this.status,
      deviceData: deviceData ?? this.deviceData,
      errorMessage: errorMessage ?? this.errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailure => status == HomeStatus.failure;
  bool get hasData => deviceData != null && deviceData!.isNotEmpty;

  @override
  List<Object?> get props => [
    status,
    deviceData,
    errorMessage,
    lastUpdated,
    isRefreshing,
  ];
}
