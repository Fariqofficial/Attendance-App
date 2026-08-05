import 'package:equatable/equatable.dart';

class Locations extends Equatable {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double radius;

  const Locations({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.radius = 50.0,
  });

  @override
  List<Object?> get props => [id, name, latitude, longitude, radius];
}
