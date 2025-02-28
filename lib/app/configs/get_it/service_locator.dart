import 'package:epenting/app/cubits/status_gizi/statusgizi_cubit.dart';
import 'package:epenting/app/repositories/statusgizi_repository.dart';
import 'package:epenting/app/services/statusgizi_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => StatusGiziService());
  sl.registerLazySingleton<StatusGiziRepository>(
    () => StatusGiziRepositoryImpl(sl()),
  );
  sl.registerFactory(() => StatusGiziCubit(sl()));
}
