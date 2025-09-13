// contact_us_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "contact_us".tr,
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
                        "get_in_touch".tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// Short description for contact
                      Text(
                        "contact_us_info".tr,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                      ),
                      SizedBox(height: 20.h),

                      /// Contact Details (MODIFIED SECTION)
                      // Pass the new translation keys to the helper function
                      _contactItem(Icons.email, "email".tr, "contact_email_value".tr),
                      SizedBox(height: 15.h),
                      _contactItem(Icons.phone, "phone".tr, "contact_phone_value".tr),
                      SizedBox(height: 15.h),
                      _contactItem(Icons.location_on, "address".tr, "contact_address_value".tr),
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

  /// Helper function (No changes needed here)
  Widget _contactItem(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 24.w),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              value, // This will now display the localized value
              style: TextStyle(fontSize: 14.sp, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}