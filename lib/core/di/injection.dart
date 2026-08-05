import 'package:get_it/get_it.dart';
import 'package:attendance_app/core/services/location_service.dart';
import 'package:attendance_app/features/attendance/data/datasource/attendance_dts.dart';
import 'package:attendance_app/features/attendance/data/datasource/attendance_dts_impl.dart';
import 'package:attendance_app/features/attendance/data/repositories_impl/attendance_repository_impl.dart';
import 'package:attendance_app/features/attendance/domain/repositories/attendance_repositories.dart';
import 'package:attendance_app/features/attendance/domain/usecase/add_locations.dart';
import 'package:attendance_app/features/attendance/domain/usecase/check_in.dart';
import 'package:attendance_app/features/attendance/domain/usecase/get_locations.dart';
import 'package:attendance_app/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:attendance_app/features/attendance/data/datasource/local_db.dart';

final di = GetIt.instance;

Future<void> initLocator() async {
  di.registerLazySingleton<LocationService>(() => LocationService());
  di.registerLazySingleton<LocalDatabase>(() => LocalDatabase());
  // ======= REPOSITORIES ========
  di.registerLazySingleton<AttendanceRepositories>(
    () => AttendanceRepositoryImpl(di()),
  );
  // ======= DATA SOURCE =========
  di.registerLazySingleton<AttendanceDTS>(() => AttendanceDTSImpl(di()));
  // ======= USE CASE ============
  di.registerLazySingleton(() => GetLocations(di()));
  di.registerLazySingleton(() => AddLocations(di()));
  di.registerLazySingleton(() => CheckIn(di()));
  // ======= CUBIT ===============
  di.registerFactory(() => AttendanceCubit(di(), di(), di(), di()));
}
