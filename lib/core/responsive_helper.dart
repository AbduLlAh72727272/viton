import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class ResponsiveHelper {
  static bool get isIOS => Platform.isIOS;
  static bool get isAndroid => Platform.isAndroid;
  
  /// Get device type for better responsiveness
  static String getDeviceType(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (isIOS) {
      if (size.width > 1000) return 'iPad';
      if (size.width > 414) return 'iPhone Plus';
      if (size.width > 375) return 'iPhone Standard';
      return 'iPhone SE';
    }
    return 'Android';
  }
  
  /// Check if device has notch/Dynamic Island
  static bool hasNotch(BuildContext context) {
    if (!isIOS) return false;
    final padding = MediaQuery.of(context).padding;
    return padding.top > 20;
  }
  
  /// Get safe area padding for iOS devices
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    if (!isIOS) return EdgeInsets.zero;
    final padding = MediaQuery.of(context).padding;
    return EdgeInsets.only(
      top: padding.top,
      bottom: padding.bottom,
      left: padding.left,
      right: padding.right,
    );
  }
  
  /// Get responsive padding based on platform
  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isIOS) {
      return EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      );
    } else {
      return EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      );
    }
  }
  
  /// Get responsive font size based on platform
  static double getResponsiveFontSize(double baseSize) {
    if (isIOS) {
      return baseSize.sp;
    } else {
      return baseSize.sp;
    }
  }
  
  /// Get responsive height based on platform
  static double getResponsiveHeight(double baseHeight) {
    if (isIOS) {
      return baseHeight.h;
    } else {
      return baseHeight.h;
    }
  }
  
  /// Get responsive width based on platform
  static double getResponsiveWidth(double baseWidth) {
    if (isIOS) {
      return baseWidth.w;
    } else {
      return baseWidth.w;
    }
  }
  
  /// Get platform-specific border radius
  static BorderRadius getResponsiveBorderRadius() {
    if (isIOS) {
      return BorderRadius.circular(12.r);
    } else {
      return BorderRadius.circular(8.r);
    }
  }
  
  /// Get platform-specific elevation/shadow
  static List<BoxShadow> getResponsiveShadow() {
    if (isIOS) {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.15),
          blurRadius: 6,
          offset: Offset(0, 2),
        ),
      ];
    }
  }
  
  /// Get platform-specific button style
  static ButtonStyle getResponsiveButtonStyle(Color backgroundColor) {
    if (isIOS) {
      return ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      );
    } else {
      return ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        elevation: 2,
      );
    }
  }
  
  /// Get platform-specific text field style
  static InputDecoration getResponsiveTextFieldDecoration({
    required String hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    if (isIOS) {
      return InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      );
    } else {
      return InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      );
    }
  }
  
  /// Get platform-specific card style
  static BoxDecoration getResponsiveCardDecoration() {
    if (isIOS) {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: getResponsiveShadow(),
      );
    } else {
      return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: getResponsiveShadow(),
      );
    }
  }
  
  /// Get platform-specific container padding
  static EdgeInsets getResponsiveContainerPadding() {
    if (isIOS) {
      return EdgeInsets.all(16.w);
    } else {
      return EdgeInsets.all(12.w);
    }
  }
  
  /// Get platform-specific spacing
  static double getResponsiveSpacing(double baseSpacing) {
    if (isIOS) {
      return (baseSpacing * 1.2).h; // iOS prefers more spacing
    } else {
      return baseSpacing.h;
    }
  }
  
  /// Get platform-specific icon size
  static double getResponsiveIconSize(double baseSize) {
    if (isIOS) {
      return (baseSize * 1.1).sp; // iOS icons slightly larger
    } else {
      return baseSize.sp;
    }
  }
  
  /// Get platform-specific app bar style
  static PreferredSizeWidget getResponsiveAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
  }) {
    if (isIOS) {
      return CupertinoNavigationBar(
        middle: Text(
          title,
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: actions != null ? Row(
          mainAxisSize: MainAxisSize.min,
          children: actions,
        ) : null,
        leading: leading,
        backgroundColor: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 0.5,
          ),
        ),
      );
    } else {
      return AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: actions,
        leading: leading,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.grey.shade200,
      );
    }
  }
  
  /// Get platform-specific bottom sheet style
  static Widget getResponsiveBottomSheet({
    required Widget child,
    double? height,
  }) {
    if (isIOS) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.r),
          ),
        ),
        child: child,
      );
    } else {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12.r),
          ),
        ),
        child: child,
      );
    }
  }
}
