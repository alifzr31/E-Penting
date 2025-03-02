import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/repositories/auth_repository.dart';
import 'package:epenting/app/repositories/dashboard_repository.dart';
import 'package:epenting/app/repositories/statusgizi_repository.dart';
import 'package:epenting/app/services/auth_service.dart';
import 'package:epenting/app/services/dashboard_service.dart';
import 'package:epenting/app/services/statusgizi_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => AuthService());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory(() => AuthCubit(sl()));

  sl.registerLazySingleton(() => StatusGiziService());
  sl.registerLazySingleton<StatusGiziRepository>(
    () => StatusGiziRepositoryImpl(sl()),
  );
  sl.registerFactory(() => StatusGiziCubit(sl()));

  sl.registerLazySingleton(() => DashboardService());
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerFactory(() => DashboardCubit(sl()));
}
