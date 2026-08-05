class CacheException implements Exception {
  final String? message;
  const CacheException([this.message]);

  @override
  String toString() => message ?? 'CacheException';
}

class ServerException implements Exception {
  final String? message;
  const ServerException([this.message]);

  @override
  String toString() => message ?? 'ServerException';
}

class LocationPermissionException implements Exception {
  final String? message;
  const LocationPermissionException([this.message]);

  @override
  String toString() => message ?? 'LocationPermissionException';
}

class LocationServiceException implements Exception {
  final String? message;
  const LocationServiceException([this.message]);

  @override
  String toString() => message ?? 'LocationServiceException';
}
