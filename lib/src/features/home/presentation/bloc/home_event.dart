part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {
  final bool isRefresh;

  const LoadHomeData({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class LogVitals extends HomeEvent {
  const LogVitals();

  @override
  List<Object?> get props => [];
}
