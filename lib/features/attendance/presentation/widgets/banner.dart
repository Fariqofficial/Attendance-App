part of '../pages/absensi_page.dart';

class _Banner extends StatelessWidget {
  final bool isWithInRadius;
  const _Banner({this.isWithInRadius = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isWithInRadius
            ? Colors.green.shade600.withValues(alpha: .5)
            : Colors.red.shade600.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isWithInRadius
                      ? 'You are in the clock-in area!'
                      : 'You are currently outside the clock-in area!',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                4.verticalSpace,
                Text(
                  isWithInRadius
                      ? 'Now you can press clock in in this area'
                      : 'Please move to the location in the clock-in area.',
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          isWithInRadius
              ? Icon(Icons.check_circle_outline, size: 30, color: Colors.white)
              : Icon(Icons.cancel_outlined, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
