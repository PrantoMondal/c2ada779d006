import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // B L O C K S
  sl.registerFactory<SplashBloc>(() => SplashBloc()..add(LoadSplash()));
  sl.registerFactory<HomeBloc>(() => HomeBloc()..add(LoadHomeData()));

  // Services / Repositories

  // sl.registerLazySingleton<MyRepository>(() => MyRepositoryImpl());
  sl.registerLazySingleton<Dio>(() => Dio());
}
