part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

@immutable
class HomeState extends Equatable {
  final HomeStatus status;
  final DeviceInfoEntity? deviceData;
  final String? errorMessage;
  final DateTime? lastUpdated;
  final bool isRefreshing;
  final String? logSuccessMessage;
  final bool isLogging;

  const HomeState({
    this.status = HomeStatus.initial,
    this.deviceData,
    this.errorMessage,
    this.lastUpdated,
    this.isRefreshing = false,
    this.logSuccessMessage,
    this.isLogging = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    DeviceInfoEntity? deviceData,
    String? Function()? errorMessage,
    DateTime? lastUpdated,
    bool? isRefreshing,
    String? Function()? logSuccessMessage,
    bool? isLogging,
  }) {
    return HomeState(
      status: status ?? this.status,
      deviceData: deviceData ?? this.deviceData,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      logSuccessMessage: logSuccessMessage != null ? logSuccessMessage() : this.logSuccessMessage,
      isLogging: isLogging ?? this.isLogging,
    );
  }

  bool get isInitial => status == HomeStatus.initial;

  bool get isLoading => status == HomeStatus.loading;

  bool get isSuccess => status == HomeStatus.success;

  bool get isFailure => status == HomeStatus.failure;

  bool get hasData => deviceData != null;

  @override
  List<Object?> get props => [
    status,
    deviceData,
    errorMessage,
    lastUpdated,
    isRefreshing,
    logSuccessMessage,
    isLogging,
  ];
}