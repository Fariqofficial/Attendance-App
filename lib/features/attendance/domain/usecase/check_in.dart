import 'package:dartz/dartz.dart';
import 'package:attendance_app/core/error/failures.dart';
import 'package:attendance_app/features/attendance/domain/repositories/attendance_repositories.dart';

class CheckIn {
  final AttendanceRepositories _repo;
  CheckIn(this._repo);

  Future<Either<Failure, bool>> call(
    String locationId,
    double userLat,
    double userLng,
  ) async => await _repo.checkIn(
    locationId: locationId,
    userLat: userLat,
    userLng: userLng,
  );
}
