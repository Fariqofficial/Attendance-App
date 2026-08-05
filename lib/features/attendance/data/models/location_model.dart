import 'package:attendance_app/features/attendance/domain/entity/locations.dart';

class LocationModel extends Locations {
  const LocationModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    super.radius,
  });

  factory LocationModel.fromJSON(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      name: json["name"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      radius: json["radius"] ?? 50.0,
    );
  }

  Map<String, dynamic> toJSON() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'radius': radius,
  };
}
