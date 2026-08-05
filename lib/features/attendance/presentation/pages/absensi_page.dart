import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_app/core/widgets/custom_base_map.dart';
import 'package:attendance_app/core/widgets/custom_flushbar.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/presentation/cubit/attendance_cubit.dart';

part '../widgets/banner.dart';
part '../widgets/profil_information.dart';

class AbsensiPage extends StatefulWidget {
  final String locationId;
  final Locations? locations;
  const AbsensiPage({super.key, required this.locationId, this.locations});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  bool isWithinRadius = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLocation();
    });
  }

  void _checkLocation() {
    context.read<AttendanceCubit>().checkIn(widget.locationId);
  }

  @override
  Widget build(BuildContext context) {
    final double lat = widget.locations?.latitude ?? -6.170729079430389;
    final double lng = widget.locations?.longitude ?? 106.81336088928971;
    final String locationName = widget.locations?.name ?? "Head Office";
    final double radius = widget.locations?.radius ?? 50.0;

    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        if (state is AttendanceError) {
          CustomFlushbar.showError(context, message: state.message);
        } else if (state is CheckInSuccess) {
          setState(() => isWithinRadius = true);
        } else if (state is CheckInRejected) {
          setState(() => isWithinRadius = false);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AttendanceLoading;
        return Scaffold(
          body: Stack(
            children: [
              //Maps
              CustomBaseMap(lat: lat, lng: lng, radius: radius),
              //App Bar
              Positioned(
                top: 50.h,
                left: 16.w,
                right: 16.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .7),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    Text(
                      'Clock In Area',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    48.horizontalSpace,
                  ],
                ),
              ),
              //Bottom Card Area
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  padding: EdgeInsets.only(top: 30.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.r),
                      topLeft: Radius.circular(20.r),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .3),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0, .5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Banner(isWithInRadius: isWithinRadius),
                              12.verticalSpace,
                              _ProfilInformation(
                                name: locationName,
                                radius: radius,
                                latitude: lat,
                                longitude: lng,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _Button(
                            isEnabled: isWithinRadius && !isLoading,
                            onTap: (isWithinRadius && !isLoading)
                                ? () {
                                    CustomFlushbar.showSuccess(
                                      context,
                                      message:
                                          "Clock-in successful, you are within the radius.",
                                    );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Center(
                    child: CupertinoActivityIndicator(
                      radius: 20.r,
                      color: const Color(0xFFAC192B),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
