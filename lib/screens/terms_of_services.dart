import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ Import GetX for localization

class TermsOfServiceScreen extends StatelessWidget {
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
          "terms_of_service_title".tr, // ✅ Use localized title
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
                child: Scrollbar(
                  thickness: 4.w,
                  radius: Radius.circular(8.r),
                  child: SingleChildScrollView(
                    child: Text(
                      "terms_of_service_content".tr, // ✅ Use localized content
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
