import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomErrorWidget extends StatelessWidget {
  final Widget? icon;
  final Function()? onRetry;
  final Color? backgroundColor;
  final Size? minimumsize;
  final BorderRadiusGeometry? borderRadius;
  final String? title;
  final TextStyle? textstyle;
  const CustomErrorWidget({
    super.key,
    this.icon,
    this.onRetry,
    this.backgroundColor,
    this.minimumsize,
    this.borderRadius,
    this.title,
    this.textstyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon ??
              Image.asset(
                "assets/icons/ic_wrong.png",
                width: 230.w,
                height: 200.h,
              ),
          8.verticalSpace,
          ElevatedButton(
            onPressed: onRetry ?? () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor ?? Color(0xFFAC192B),
              minimumSize: minimumsize ?? Size(150.w, 40.h),
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              title ?? "Coba Lagi",
              style: textstyle ?? GoogleFonts.inter(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
