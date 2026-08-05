import 'package:dartz/dartz.dart';
import 'package:attendance_app/core/error/exceptions.dart';
import 'package:attendance_app/core/error/failures.dart';
import 'package:attendance_app/features/attendance/data/datasource/attendance_dts.dart';
import 'package:attendance_app/features/attendance/data/models/location_model.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/domain/repositories/attendance_repositories.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

class AttendanceRepositoryImpl implements AttendanceRepositories {
  final AttendanceDTS _attendanceDTS;
  final Uuid _uuid = Uuid();
  AttendanceRepositoryImpl(this._attendanceDTS);

  @override
  Future<Either<Failure, Locations>> addLocation(Locations location) async {
    try {
      final data = LocationModel(
        id: _uuid.v4(),
        name: location.name,
        latitude: location.latitude,
        longitude: location.longitude,
        radius: location.radius,
      );
      final result = await _attendanceDTS.addLocation(data);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message ?? 'Gagal menyimpan lokasi'));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIn({
    required String locationId,
    required double userLat,
    required double userLng,
  }) async {
    try {
      final data = await _attendanceDTS.getLocationById(locationId);
      if (data == null) return Left(CacheFailure('Lokasi tidak ditemukan'));
      final distanceInMeters = Geolocator.distanceBetween(
        data.latitude,
        data.longitude,
        userLat,
        userLng,
      );
      final isWithinRadius = distanceInMeters <= data.radius;
      return Right(isWithinRadius);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message ?? 'Gagal melakukan absensi'));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Locations>>> getAllLocations() async {
    try {
      final data = await _attendanceDTS.getAllLocations();
      return Right(data);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message ?? 'Gagal mendapatkan data lokasi'));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
