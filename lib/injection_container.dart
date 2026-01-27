import 'package:device_vitals/src/features/history/data/datasource/history_remote_datasource.dart';
import 'package:device_vitals/src/features/history/data/repository/history_repository_impl.dart';
import 'package:device_vitals/src/features/history/domain/repository/history_repository.dart';
import 'package:device_vitals/src/features/history/domain/usecases/get_history.dart';
import 'package:device_vitals/src/features/history/presentation/bloc/history_bloc.dart';
import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'src/features/home/data/datasources/device_info_datasource.dart';
import 'src/features/home/data/repositories/device_info_repository_impl.dart';
import 'src/features/home/domain/repositories/device_info_repository.dart';
import 'src/features/home/domain/usecases/get_device_info.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  // D A T A   S O U R C E S
  sl.registerLazySingleton<DeviceInfoDataSource>(() => DeviceInfoDataSource());
  sl.registerLazySingleton<HistoryRemoteDataSource>(() => HistoryRemoteDataSource());

  // R E P O S I T O R I E S
  sl.registerLazySingleton<DeviceInfoRepository>(() => DeviceInfoRepositoryImpl(sl<DeviceInfoDataSource>()));
  sl.registerLazySingleton<HistoryRepository>(() => HistoryRepositoryImpl(sl<HistoryRemoteDataSource>()));

  // U S E   C A S E S
  sl.registerLazySingleton<GetDeviceInfo>(() => GetDeviceInfo(sl<DeviceInfoRepository>()));
  sl.registerLazySingleton<GetHistory>(() => GetHistory(sl<HistoryRepository>()));

  // B L O C K S
  sl.registerFactory<SplashBloc>(() => SplashBloc()..add(LoadSplash()));
  sl.registerFactory<HomeBloc>(() => HomeBloc(getDeviceInfo: sl<GetDeviceInfo>())..add(const LoadHomeData()));
  sl.registerFactory<HistoryBloc>(() => HistoryBloc(getHistory: sl<GetHistory>())..add(const LoadHistory()));

  // D I O
  sl.registerLazySingleton<Dio>(() => Dio());
}
