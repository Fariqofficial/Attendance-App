part of 'attendance_cubit.dart';

sealed class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

final class AttendanceInitial extends AttendanceState {}

final class AttendanceLoading extends AttendanceState {}

final class LocationsLoaded extends AttendanceState {
  final List<Locations> locations;
  const LocationsLoaded({required this.locations});

  @override
  List<Object> get props => [locations];
}

final class LocationAddedSuccess extends AttendanceState {}

final class CheckInSuccess extends AttendanceState {
  final double latitude;
  final double longitude;
  const CheckInSuccess({required this.latitude, required this.longitude});
  @override
  List<Object> get props => [latitude, longitude];
}

final class CheckInRejected extends AttendanceState {
  final double latitude;
  final double longitude;
  const CheckInRejected({required this.latitude, required this.longitude});
  @override
  List<Object> get props => [latitude, longitude];
}

final class AttendanceError extends AttendanceState {
  final String message;
  const AttendanceError({required this.message});
  @override
  List<Object> get props => [message];
}

final class AttendanceLoadingGPS extends AttendanceState {}

final class GPSLocationLoaded extends AttendanceState {
  final double latitude;
  final double longitude;

  const GPSLocationLoaded({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}
