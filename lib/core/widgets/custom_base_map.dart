import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class CustomBaseMap extends StatelessWidget {
  final double lat;
  final double lng;
  final double radius;
  final MapController? mapController;
  final Function(LatLng point)? onTap;
  final Widget? customMarker;
  final Function(MapCamera, bool)? onPositionChanged;
  const CustomBaseMap({
    super.key,
    required this.lat,
    required this.lng,
    this.radius = 50,
    this.mapController,
    this.onTap,
    this.customMarker,
    this.onPositionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(lat, lng),
        initialZoom: 18.0,
        onTap: (tapPosition, point) {
          if (onTap != null) onTap!(point);
        },
        onPositionChanged: onPositionChanged,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.de/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.riqsu.attendance_app',
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(lat, lng),
              radius: radius,
              useRadiusInMeter: true,
              borderStrokeWidth: 2,
              color: const Color(0xFFAC192B).withValues(alpha: .4),
              borderColor: const Color(0xFFAC192B),
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: LatLng(lat, lng),
              width: 60.w,
              height: 60.h,
              child:
                  customMarker ??
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFAC192B),
                        width: 2.w,
                      ),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
