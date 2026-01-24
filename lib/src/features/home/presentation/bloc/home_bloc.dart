import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  void _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(const HomeSuccess(message: "Home data loaded successfully"));
    } catch (e) {
      emit(HomeError("Failed to load home data"));
    }
  }
}
