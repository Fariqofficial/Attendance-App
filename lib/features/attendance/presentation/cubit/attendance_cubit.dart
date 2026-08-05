import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:attendance_app/core/error/failures.dart';
import 'package:attendance_app/core/services/location_service.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/domain/usecase/add_locations.dart';
import 'package:attendance_app/features/attendance/domain/usecase/check_in.dart';
import 'package:attendance_app/features/attendance/domain/usecase/get_locations.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  final GetLocations _getLocations;
  final AddLocations _addLocations;
  final LocationService _locationService;
  final CheckIn _checkIn;
  AttendanceCubit(
    this._getLocations,
    this._addLocations,
    this._checkIn,
    this._locationService,
  ) : super(AttendanceInitial());

  Future<void> getCurrentLocation() async {
    emit(AttendanceLoadingGPS());
    try {
      final position = await _locationService.getCurrentPosition();
      emit(
        GPSLocationLoaded(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      emit(
        AttendanceError(message: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  Future<void> loadLocations() async {
    emit(AttendanceLoading());
    final result = await _getLocations.call();
    result.fold(
      (failure) => emit(AttendanceError(message: _messageFailure(failure))),
      (data) => emit(LocationsLoaded(locations: data)),
    );
  }

  Future<void> createLocation({
    required String name,
    required double latitude,
    required double longitude,
    double radius = 50.0,
  }) async {
    emit(AttendanceLoading());

    final data = Locations(
      id: '',
      name: name,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );

    final result = await _addLocations.call(data);
    result.fold(
      (failure) => emit(AttendanceError(message: _messageFailure(failure))),
      (data) {
        emit(LocationAddedSuccess());
      },
    );
  }

  Future<void> checkIn(String locationId) async {
    emit(AttendanceLoading());
    try {
      final Position position = await _locationService.getCurrentPosition();

      final result = await _checkIn.call(
        locationId,
        position.latitude,
        position.longitude,
      );

      result.fold(
        (failure) => emit(AttendanceError(message: _messageFailure(failure))),
        (isWithinRadius) {
          if (isWithinRadius) {
            emit(
              CheckInSuccess(
                latitude: position.latitude,
                longitude: position.longitude,
              ),
            );
          } else {
            emit(
              CheckInRejected(
                latitude: position.latitude,
                longitude: position.longitude,
              ),
            );
          }
        },
      );
    } catch (e) {
      emit(
        AttendanceError(message: e.toString().replaceAll('Exception: ', '')),
      );
    }
  }

  String _messageFailure(Failure failure) {
    if (failure is ServerFailure) return 'Terjadi kesalahan pada server';
    if (failure is CacheFailure) return failure.message;
    if (failure is LocationFailure) return failure.message;
    if (failure is PermissionFailure) return failure.message;
    return 'Terjadi kesalahan yang tidak diketahui';
  }
}
