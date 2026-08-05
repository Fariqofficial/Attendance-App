import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String id;
  final String locationId;
  final DateTime timeStamp;
  final double userLat;
  final double userLng;
  final StatusAttendance status;

  const Attendance({
    required this.id,
    required this.locationId,
    required this.timeStamp,
    required this.userLat,
    required this.userLng,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    locationId,
    timeStamp,
    userLat,
    userLng,
    status,
  ];
}

enum StatusAttendance { presence, rejected, pending }
