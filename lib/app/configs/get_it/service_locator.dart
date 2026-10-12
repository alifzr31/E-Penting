import 'package:biometric_storage/biometric_storage.dart';
import 'package:e_penting/app/configs/dio/dio_client.dart';
import 'package:e_penting/app/configs/firebase/firebase_notification.dart';
import 'package:e_penting/app/configs/firebase/firebase_remote.dart';
import 'package:e_penting/app/configs/local_notification/local_notification.dart';
import 'package:e_penting/app/configs/router/app_router.dart';
import 'package:e_penting/app/configs/secure_storage/secure_storage.dart';
import 'package:e_penting/app/cubits/auth/auth_cubit.dart';
import 'package:e_penting/app/cubits/biometric/biometric_cubit.dart';
import 'package:e_penting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:e_penting/app/cubits/immunization/immunization_cubit.dart';
import 'package:e_penting/app/cubits/login/login_cubit.dart';
import 'package:e_penting/app/cubits/measurement/measurement_cubit.dart';
import 'package:e_penting/app/cubits/nutrition/nutrition_cubit.dart';
import 'package:e_penting/app/cubits/onboard/onboard_cubit.dart';
import 'package:e_penting/app/cubits/package_info/package_info_cubit.dart';
import 'package:e_penting/app/cubits/selected_child/selected_child_cubit.dart';
import 'package:e_penting/app/cubits/splash/splash_cubit.dart';
import 'package:e_penting/app/cubits/stat/stat_cubit.dart';
import 'package:e_penting/app/cubits/toddler/toddler_cubit.dart';
import 'package:e_penting/app/repositories/auth_repository.dart';
import 'package:e_penting/app/repositories/biometric_repository.dart';
import 'package:e_penting/app/repositories/immunization_repository.dart';
import 'package:e_penting/app/repositories/login_repository.dart';
import 'package:e_penting/app/repositories/measurement_repository.dart';
import 'package:e_penting/app/repositories/nutrition_repository.dart';
import 'package:e_penting/app/repositories/stat_repository.dart';
import 'package:e_penting/app/repositories/toddler_repository.dart';
import 'package:e_penting/app/services/auth_service.dart';
import 'package:e_penting/app/services/biometric_service.dart';
import 'package:e_penting/app/services/immunization_service.dart';
import 'package:e_penting/app/services/login_service.dart';
import 'package:e_penting/app/services/measurement_service.dart';
import 'package:e_penting/app/services/nutrition_service.dart';
import 'package:e_penting/app/services/stat_service.dart';
import 'package:e_penting/app/services/toddler_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  sl.registerLazySingleton<SecureStorage>(
    () => const SecureStorage(FlutterSecureStorage()),
  );

  sl.registerLazySingleton<FirebaseRemote>(
    () => FirebaseRemote(FirebaseRemoteConfig.instance),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  sl.registerLazySingleton<LocalNotification>(() => LocalNotification());
  sl.registerLazySingleton<FirebaseNotification>(
    () => FirebaseNotification(sl()),
  );

  sl.registerLazySingleton<PackageInfoCubit>(
    () => PackageInfoCubit()..fetchAppInfo(),
  );

  sl.registerLazySingleton<BiometricService>(
    () => BiometricService(LocalAuthentication(), BiometricStorage()),
  );
  sl.registerLazySingleton<BiometricRepository>(
    () => BiometricRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<BiometricCubit>(() => BiometricCubit(sl()));

  sl.registerLazySingleton<AuthService>(() => AuthService(sl(), sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<AuthCubit>(() => AuthCubit(sl(), sl()));

  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl(), sl(), sl()));

  sl.registerFactory<OnboardCubit>(() => OnboardCubit());

  sl.registerLazySingleton<LoginService>(() => LoginService(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerFactory<LoginCubit>(() => LoginCubit(sl(), sl()));

  sl.registerLazySingleton<NutritionService>(() => NutritionService(sl()));
  sl.registerLazySingleton<NutritionRepository>(
    () => NutritionRepositoryImpl(sl()),
  );
  sl.registerFactory<NutritionCubit>(() => NutritionCubit(sl()));

  sl.registerFactory<DashboardCubit>(() => DashboardCubit());

  sl.registerFactory<SelectedChildCubit>(() => SelectedChildCubit());

  sl.registerLazySingleton<ToddlerService>(() => ToddlerService(sl()));
  sl.registerLazySingleton<ToddlerRepository>(
    () => ToddlerRepositoryImpl(sl()),
  );
  sl.registerFactory<ToddlerCubit>(() => ToddlerCubit(sl()));

  sl.registerLazySingleton<ImmunizationService>(
    () => ImmunizationService(sl()),
  );
  sl.registerLazySingleton<ImmunizationRepository>(
    () => ImmunizationRepositoryImpl(sl()),
  );
  sl.registerFactory<ImmunizationCubit>(() => ImmunizationCubit(sl()));

  sl.registerLazySingleton<MeasurementService>(() => MeasurementService(sl()));
  sl.registerLazySingleton<MeasurementRepository>(
    () => MeasurementRepositoryImpl(sl()),
  );
  sl.registerFactory<MeasurementCubit>(() => MeasurementCubit(sl()));

  sl.registerLazySingleton<StatService>(() => StatService(sl()));
  sl.registerLazySingleton<StatRepository>(() => StatRepositoryImpl(sl()));
  sl.registerFactory<StatCubit>(() => StatCubit(sl()));
}
