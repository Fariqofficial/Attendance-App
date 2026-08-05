import 'package:attendance_app/core/error/exceptions.dart';
import 'package:attendance_app/features/attendance/data/datasource/attendance_dts.dart';
import 'package:attendance_app/features/attendance/data/datasource/local_db.dart';
import 'package:attendance_app/features/attendance/data/models/location_model.dart';
import 'package:sqflite/sqlite_api.dart';

class AttendanceDTSImpl implements AttendanceDTS {
  final LocalDatabase _localDB;
  AttendanceDTSImpl(this._localDB);

  @override
  Future<LocationModel> addLocation(LocationModel location) async {
    try {
      final db = await _localDB.db;
      await db.insert(
        'locations',
        location.toJSON(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return location;
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<List<LocationModel>> getAllLocations() async {
    try {
      final database = await _localDB.db;
      final List<Map<String, dynamic>> result = await database.query(
        'locations',
      );

      return result.map((e) => LocationModel.fromJSON(e)).toList();
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<LocationModel?> getLocationById(String id) async {
    try {
      final db = await _localDB.db;
      final result = await db.query(
        'locations',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) return null;
      return LocationModel.fromJSON(result.first);
    } on Exception catch (e) {
      throw CacheException(e.toString());
    }
  }
}
