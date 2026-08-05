import 'package:attendance_app/features/attendance/data/models/location_model.dart';

abstract class AttendanceDTS {
  Future<List<LocationModel>> getAllLocations();
  Future<LocationModel> addLocation(LocationModel location);
  Future<LocationModel?> getLocationById(String id);
}
