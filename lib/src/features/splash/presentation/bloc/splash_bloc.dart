import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<LoadSplash>((event, emit) async {
      emit(SplashLoading());
      try {
        await Future.delayed(const Duration(seconds: 2));
        emit(SplashSuccess());
      } catch (e) {
        emit(SplashError("Something went wrong"));
      }
    });
  }
}
