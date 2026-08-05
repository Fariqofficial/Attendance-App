part of '../pages/add_location_page.dart';

class _LocationPickerMap extends StatelessWidget {
  final double lat;
  final double lng;
  final double radius;
  final MapController mapController;
  final bool isLoadingGps;
  final Function(LatLng) onTapMap;
  final VoidCallback onGetLocation;
  final Function(MapCamera, bool)? onPositionChanged;
  const _LocationPickerMap({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.mapController,
    required this.isLoadingGps,
    required this.onTapMap,
    required this.onGetLocation,
    this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomBaseMap(
          lat: lat,
          lng: lng,
          radius: radius,
          mapController: mapController,
          customMarker: const Icon(
            Icons.location_pin,
            color: Color(0xFFAC192B),
            size: 40,
          ),
          onTap: onTapMap,
          onPositionChanged: onPositionChanged,
        ),
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFAC192B),
            onPressed: isLoadingGps ? null : onGetLocation,
            child: isLoadingGps
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
          ),
        ),
      ],
    );
  }
}
