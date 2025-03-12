import 'package:epenting/app/cubits/auth/auth_cubit.dart';
import 'package:epenting/app/cubits/dashboard/dashboard_cubit.dart';
import 'package:epenting/app/cubits/imunisasi/imunisasi_cubit.dart';
import 'package:epenting/app/cubits/pengukuran/pengukuran_cubit.dart';
import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/repositories/auth_repository.dart';
import 'package:epenting/app/repositories/dashboard_repository.dart';
import 'package:epenting/app/repositories/imunisasi_repository.dart';
import 'package:epenting/app/repositories/pengukuran_repository.dart';
import 'package:epenting/app/repositories/statusgizi_repository.dart';
import 'package:epenting/app/services/auth_service.dart';
import 'package:epenting/app/services/dashboard_service.dart';
import 'package:epenting/app/services/imunisasi_service.dart';
import 'package:epenting/app/services/pengukuran_service.dart';
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

  sl.registerLazySingleton(() => PengukuranService());
  sl.registerLazySingleton<PengukuranRepository>(
    () => PengukuranRepositoryImpl(sl()),
  );
  sl.registerFactory(() => PengukuranCubit(sl()));

  sl.registerLazySingleton(() => ImunisasiService());
  sl.registerLazySingleton<ImunisasiRepository>(
    () => ImunisasiRepositoryImpl(sl()),
  );
  sl.registerFactory(() => ImunisasiCubit(sl()));
}
