import 'package:attendance_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';

abstract class AttendanceRepositories {
  Future<Either<Failure, List<Locations>>> getAllLocations();
  Future<Either<Failure, Locations>> addLocation(Locations location);
  Future<Either<Failure, bool>> checkIn({
    required String locationId,
    required double userLat,
    required double userLng,
  });
}
