import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance_app/core/widgets/custom_empty_widget.dart';
import 'package:attendance_app/core/widgets/custom_error_widget.dart';
import 'package:attendance_app/core/widgets/custom_flushbar.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/presentation/cubit/attendance_cubit.dart';

part '../widgets/location_card.dart';

class LocationListPage extends StatelessWidget {
  const LocationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFAC192B),
        title: Text(
          "Location List",
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        elevation: 1,
      ),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceError) {
            CustomFlushbar.showError(context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: Center(
                child: CupertinoActivityIndicator(
                  radius: 20.r,
                  color: Color(0xFFAC192B),
                ),
              ),
            );
          }
          if (state is LocationsLoaded) {
            if (state.locations.isEmpty) return CustomEmptyWidget();

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              separatorBuilder: (_, __) => 12.verticalSpace,
              itemCount: state.locations.length,
              itemBuilder: (context, index) {
                final location = state.locations[index];
                return _LocationCard(
                  location: location,
                  onTap: () =>
                      context.push('/absensi/${location.id}', extra: location),
                );
              },
            );
          }

          return CustomErrorWidget(
            onRetry: () => context.read<AttendanceCubit>().loadLocations(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool? isAdded = await context.push<bool>('/add-locations');

          if (isAdded == true && context.mounted) {
            CustomFlushbar.showSuccess(
              context,
              message: "Lokasi baru berhasil ditambahkan",
            );
            context.read<AttendanceCubit>().loadLocations();
          }
        },
        backgroundColor: const Color(0xFFAC192B),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
