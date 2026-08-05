import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_app/core/widgets/custom_base_map.dart';
import 'package:attendance_app/core/widgets/custom_flushbar.dart';
import 'package:attendance_app/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:latlong2/latlong.dart';

part '../widgets/location_picker.dart';
part '../widgets/location_form_card.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  final MapController _mapController = MapController();
  final _formKey = GlobalKey<FormState>();
  final Geocoding geocoding = Geocoding();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController(
    text: '50',
  );

  LatLng _selectedLatLng = const LatLng(-6.170729079430389, 106.81336088928971);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getAddressFromLatLng(_selectedLatLng);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _radiusController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        String street = place.street ?? '';
        final subLocality = place.subLocality ?? '';
        final locality = place.locality ?? '';

        String locationName = [
          street,
          subLocality,
          locality,
        ].where((element) => element.isNotEmpty).join(', ');

        setState(() => _nameController.text = locationName);
      } else {
        setState(() => _nameController.text = '');
      }
    } catch (e) {
      setState(() => _nameController.text = '');
    }
  }

  void _saveLocation() {
    if (_formKey.currentState!.validate()) {
      final radius = double.tryParse(_radiusController.text) ?? 50.0;

      context.read<AttendanceCubit>().createLocation(
        name: _nameController.text,
        latitude: _selectedLatLng.latitude,
        longitude: _selectedLatLng.longitude,
        radius: radius,
      );
    }
  }

  void _onLocationChanged(LatLng newPos) {
    setState(() {
      _selectedLatLng = newPos;
    });
    _getAddressFromLatLng(newPos);
  }

  @override
  Widget build(BuildContext context) {
    double currentRadius = double.tryParse(_radiusController.text) ?? 50;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        backgroundColor: Color(0xFFAC192B),
        title: Text(
          "Add Location",
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceError) {
            CustomFlushbar.showError(context, message: state.message);
          } else if (state is GPSLocationLoaded) {
            final newPos = LatLng(state.latitude, state.longitude);
            setState(() {
              _selectedLatLng = newPos;
            });
            _mapController.move(_selectedLatLng, 18.5);
            _onLocationChanged(newPos);
          } else if (state is LocationAddedSuccess) {
            if (context.mounted) {
              context.pop(true);
            }
          }
        },
        builder: (context, state) {
          final bool isLoadingGPS = state is GPSLocationLoaded;
          return Stack(
            children: [
              Positioned.fill(
                child: _LocationPickerMap(
                  lat: _selectedLatLng.latitude,
                  lng: _selectedLatLng.longitude,
                  radius: currentRadius,
                  mapController: _mapController,
                  isLoadingGps: isLoadingGPS,
                  onTapMap: _onLocationChanged,
                  onPositionChanged: (camera, hasGesture) {
                    if (hasGesture) {
                      _onLocationChanged(camera.center);
                    }
                  },
                  onGetLocation: () =>
                      context.read<AttendanceCubit>().getCurrentLocation(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _LocationFormCard(
                  formKey: _formKey,
                  nameController: _nameController,
                  radiusController: _radiusController,
                  currentLat: _selectedLatLng.latitude,
                  currentLng: _selectedLatLng.longitude,
                  onRadiusChanged: () => setState(() {}),
                  onSave: _saveLocation,
                ),
              ),
              if (state is AttendanceLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 20.r,
                      color: Color(0xFFAC192B),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
