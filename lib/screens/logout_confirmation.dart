import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🎨 Change background color if needed
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // 🔄 Navigate back
        ),
        title: Text(
          "log_out".tr, // ✅ Localized text (Modify in translation files)
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // ✅ Center logout message
          children: [
            /// **Logout Confirmation Message**
            Text(
              "logout_confirmation".tr, // ✅ Localized confirmation text
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, color: Colors.black),
            ),

            SizedBox(height: 20.h),

            /// **Yes / No Buttons**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// **Cancel (No) Button**
                ElevatedButton(
                  onPressed: () => Navigator.pop(context), // 🔄 Close dialog
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // 🎨 Button color
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  ),
                  child: Text(
                    "no".tr, // ✅ Localized text for "No"
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),

                SizedBox(width: 20.w),

                /// **Confirm Logout Button**
                ElevatedButton(
                  onPressed: () {
                    // 🛑 Add logout logic here (e.g., Firebase signOut, clearing session)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // 🎨 Logout button color
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  ),
                  child: Text(
                    "log_out".tr, // ✅ Localized text for "Log Out"
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
