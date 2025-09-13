import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/responsive_helper.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double? width;
  final double? height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.orangeAccent,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? ResponsiveHelper.getResponsiveWidth(250),
      height: height ?? ResponsiveHelper.getResponsiveHeight(50),
      child: ElevatedButton(
        style: ResponsiveHelper.getResponsiveButtonStyle(backgroundColor).copyWith(
          side: MaterialStateProperty.all(
            BorderSide(
              color: borderColor,
              width: borderColor == Colors.transparent ? 0 : 2,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(16),
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
