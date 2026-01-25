import 'package:device_vitals/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:device_vitals/src/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'src/features/home/data/datasources/device_info_datasource.dart';
import 'src/features/home/data/repositories/device_info_repository_impl.dart';
import 'src/features/home/domain/repositories/device_info_repository.dart';
import 'src/features/home/domain/usecases/get_device_info.dart';

final sl = GetIt.instance;

// D A T A   S O U R C E S
Future<void> setupDependencies() async {
  sl.registerLazySingleton<DeviceInfoDataSource>(() => DeviceInfoDataSource());

  // R E P O S I T O R I E S
  sl.registerLazySingleton<DeviceInfoRepository>(
    () => DeviceInfoRepositoryImpl(sl<DeviceInfoDataSource>()),
  );

  // U S E   C A S E S
  sl.registerLazySingleton<GetDeviceInfo>(
    () => GetDeviceInfo(sl<DeviceInfoRepository>()),
  );

  // B L O C K S
  sl.registerFactory<SplashBloc>(() => SplashBloc()..add(LoadSplash()));
  sl.registerFactory<HomeBloc>(
    () => HomeBloc(getDeviceInfo: sl<GetDeviceInfo>())..add(const LoadHomeData()),
  );

  sl.registerLazySingleton<Dio>(() => Dio());
}
