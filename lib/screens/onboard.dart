import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routes/app_routes.dart'; // ✅ Routes for navigation
import '../widgets/toggle.dart'; // ✅ Language Toggle Widget

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// **Background Gradient**
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD19688),
                  Color(0xFFB8860B),
                  Color(0xFF8B4513),
                ],
              ),
            ),
          ),

          /// **Language Toggle Positioned at Top Right**
          Positioned(
            top: 50.h, // 📏 Adjust positioning if needed
            right: 20.w,
            child: LanguageToggle(), // 🌍 Language switch widget
          ),

          /// **Main Content Positioned at the Bottom**
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, // 📌 Align content to bottom
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// **Localized Welcome Message**
                Text(
                  'welcome_to'.tr, // ✅ Localized text (Modify in translations)
                  style: TextStyle(
                    fontSize: 26.sp, // 📏 Responsive text size
                    fontWeight: FontWeight.w400,
                    color: Colors.white, // 🎨 Change text color if needed
                  ),
                ),

                SizedBox(height: 10.h),

                /// **Localized App Name**
                Text(
                  'app_name'.tr, // ✅ Localized app name
                  style: TextStyle(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 30.h),

                /// **Login Button**
                _buildButton('login'.tr, Routes.LOGIN),

                SizedBox(height: 10.h),

                /// **Register Button**
                _buildButton('register'.tr, Routes.SIGNUP),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Button Widget for Navigation**
  Widget _buildButton(String text, String route) {
    return SizedBox(
      width: 250.w,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(route); // ✅ Navigate to the respective screen
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // 🎨 Change button color here
          foregroundColor: Colors.black, // 🎨 Change text color here
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
          elevation: 5,
        ),
        child: Text(
          text, // 🔤 Localized button text (Login/Register)
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
