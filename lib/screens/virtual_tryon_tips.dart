import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation
import 'image_posting.dart'; // ✅ Navigation to Image Posting screen

class VirtualTryOnTips extends StatefulWidget {
  @override
  _VirtualTryOnTipsState createState() => _VirtualTryOnTipsState();
}

class _VirtualTryOnTipsState extends State<VirtualTryOnTips> {
  @override
  Widget build(BuildContext context) {
    // ✅ Get the current language setting
    String currentLang = Get.locale?.languageCode ?? 'en';

    // ✅ Select the appropriate image based on language
    String imagePath = currentLang == 'el'
        ? 'assets/images/virtual_tryon_tips_greek.jpg'
        : 'assets/images/virtual_tryon_tips.jpg';

    return Scaffold(
      backgroundColor: Colors.white, // 🎨 Change background color if needed
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // 🔄 Navigate back
        ),
        title: Text(
          "Virtual Try-On Tips".tr, // ✅ Localized title (Modify in translations)
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            /// **Background Image (Switches based on language)**
            Positioned(
              top: -20.h,
              left: 0,
              right: 0,
              child: Image.asset(
                imagePath, // 🖼 Change background image here
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.85,
                fit: BoxFit.contain,
              ),
            ),

            /// **Bottom Section with "Generate Try-On" Button**
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.75),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50.h,

                    /// **Generate Try-On Button**
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => ImagePosting()); // ✅ Navigate to Image Posting screen
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // 🎨 Change button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        elevation: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Generate Try On".tr, // ✅ Localized button text
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
                        ],
                      ),
                    ),
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
