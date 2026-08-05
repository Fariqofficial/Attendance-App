import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomEmptyWidget extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final TextStyle? textstyle;
  const CustomEmptyWidget({super.key, this.icon, this.title, this.textstyle});

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
                "assets/icons/ic_no_data.png",
                width: 250.w,
                height: 200.h,
              ),
          8.verticalSpace,
          Text(
            title ?? "No Data",
            style:
                textstyle ??
                GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
          ),
        ],
      ),
    );
  }
}
