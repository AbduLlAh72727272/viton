import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.orangeAccent,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      height: 50.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: BorderSide(color: borderColor, width: borderColor == Colors.transparent ? 0 : 2),
          ),
          elevation: backgroundColor == Colors.transparent ? 0 : 5,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
