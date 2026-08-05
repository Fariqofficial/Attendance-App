part of '../pages/add_location_page.dart';

class _LocationFormCard extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController radiusController;
  final double currentLat;
  final double currentLng;
  final VoidCallback onRadiusChanged;
  final VoidCallback onSave;
  const _LocationFormCard({
    required this.formKey,
    required this.nameController,
    required this.radiusController,
    required this.currentLat,
    required this.currentLng,
    required this.onRadiusChanged,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            10.verticalSpace,
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Location Name",
                hintText: "e.g Head Office",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              validator: (val) =>
                  val == null || val.isEmpty ? "Nama lokasi wajib diisi" : null,
            ),
            12.verticalSpace,
            TextFormField(
              controller: radiusController,
              decoration: InputDecoration(
                labelText: "Radius (Meter)",
                hintText: "e.g. 50",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onChanged: (_) => onRadiusChanged(),
              validator: (val) =>
                  val == null || val.isEmpty ? "Radius wajib diisi" : null,
            ),
            8.verticalSpace,
            Text(
              "Lat: ${currentLat.toStringAsFixed(6)}, Lng: ${currentLng.toStringAsFixed(6)}",
              style: GoogleFonts.inter(fontSize: 11.sp, color: Colors.grey),
            ),
            25.verticalSpace,
            ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFAC192B),
                minimumSize: Size(double.infinity, 45.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                "Save Location",
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
