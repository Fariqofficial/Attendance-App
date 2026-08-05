import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:attendance_app/core/di/injection.dart';
import 'package:attendance_app/features/attendance/domain/entity/locations.dart';
import 'package:attendance_app/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:attendance_app/features/attendance/presentation/pages/absensi_page.dart';
import 'package:attendance_app/features/attendance/presentation/pages/add_location_page.dart';
import 'package:attendance_app/features/attendance/presentation/pages/location_list_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/locations',
    routes: [
      GoRoute(
        path: '/locations',
        builder: (context, state) => BlocProvider(
          create: (context) => di<AttendanceCubit>()..loadLocations(),
          child: LocationListPage(),
        ),
      ),
      GoRoute(
        path: '/add-locations',
        builder: (context, state) => BlocProvider(
          create: (context) => di<AttendanceCubit>(),
          child: AddLocationPage(),
        ),
      ),
      GoRoute(
        path: '/absensi/:locationId',
        builder: (context, state) {
          final locationId = state.pathParameters['locationId'] ?? '';
          final location = state.extra as Locations?;
          return BlocProvider(
            create: (context) => di<AttendanceCubit>(),
            child: AbsensiPage(locationId: locationId, locations: location),
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Halaman tidak ditemukan'))),
  );
}
