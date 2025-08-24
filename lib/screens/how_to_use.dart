import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HowToUseScreen extends StatelessWidget {
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
          'how_to_use_title'.tr, // 🔤 localized
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
                  boxShadow: const [
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
                      /// Title
                      Text(
                        'how_to_use_heading'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.h),

                      /// Intro
                      Text(
                        'how_to_use_intro'.tr,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                      ),
                      SizedBox(height: 20.h),

                      /// Steps
                      _instructionItem('step1_title'.tr, 'step1_desc'.tr),
                      _instructionItem('step2_title'.tr, 'step2_desc'.tr),
                      _instructionItem('step3_title'.tr, 'step3_desc'.tr),
                      _instructionItem('step5_title'.tr, 'step5_desc'.tr),
                      _instructionItem('step6_title'.tr, 'step6_desc'.tr),

                      SizedBox(height: 20.h),

                      /// Support
                      Text(
                        'need_help_line'.tr,
                        style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                      ),
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

  /// Reusable row
  Widget _instructionItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20.w),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
