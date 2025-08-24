import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ Import GetX for localization

class ContactUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // 🔄 Go back to the previous screen
        ),
        title: Text(
          "contact_us".tr, // ✅ Localized text (Change in translation files)
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title Section
                      Text(
                        "get_in_touch".tr, // ✅ Localized text for "Get in Touch"
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// Short description for contact
                      Text(
                        "contact_us_info".tr, // ✅ Localized text for description
                        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                      ),
                      SizedBox(height: 20.h),

                      /// Contact Details (Modify these values if needed)
                      _contactItem(Icons.email, "email".tr, "info@mmmm.com"), // 📧 Email
                      SizedBox(height: 15.h),
                      _contactItem(Icons.phone, "phone".tr, "+1 234 567 890"), // 📞 Phone number
                      SizedBox(height: 15.h),
                      _contactItem(Icons.location_on, "address".tr, "1234 Virtual Try-On St, Fashion City, NY 10001"), // 📍 Address
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to create a contact info row (icon + text)
  Widget _contactItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 24.w), // 📌 Contact Icon
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, // 🔤 Localized title (email, phone, address, etc.)
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              value, // 📝 The actual contact info (Modify as needed)
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
