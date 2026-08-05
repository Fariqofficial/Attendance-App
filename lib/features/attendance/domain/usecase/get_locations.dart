import 'package:dartz/dartz.dart';
import 'package:attendance_app/core/error/failures.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/domain/repositories/attendance_repositories.dart';

class GetLocations {
  final AttendanceRepositories _repo;
  GetLocations(this._repo);

  Future<Either<Failure, List<Locations>>> call() async =>
      await _repo.getAllLocations();
}
