import 'package:dartz/dartz.dart';
import 'package:attendance_app/core/error/failures.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/domain/repositories/attendance_repositories.dart';

class AddLocations {
  final AttendanceRepositories _repo;
  AddLocations(this._repo);

  Future<Either<Failure, Locations>> call(Locations data) async =>
      await _repo.addLocation(data);
}
