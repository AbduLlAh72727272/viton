import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ GetX for navigation & state management
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Remember Me feature
import 'package:google_fonts/google_fonts.dart'; // 🎨 Custom fonts
import 'dart:async';
import 'package:animate_do/animate_do.dart'; // 🎬 Animation package

import '../routes/app_routes.dart'; // 🔄 App navigation routes
import '../widgets/bottom_navbar.dart'; // ✅ User Navigation

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController; // 🎬 Logo animation controller
  late Animation<double> _logoAnimation; // 📏 Logo scaling animation

  @override
  void initState() {
    super.initState();
    _checkUserLoginStatus(); // ✅ Check if user is logged in

    // 🔄 Initialize animation controller
    _logoController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _logoAnimation = Tween<double>(begin: 0.6, end: 1.2).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _logoController.forward(); // ▶ Start animation
  }

  @override
  void dispose() {
    _logoController.dispose(); // 🛑 Dispose animation to avoid memory leaks
    super.dispose();
  }

  /// **Check if User is Logged In (Using SharedPreferences)**
  Future<void> _checkUserLoginStatus() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUID = prefs.getString('user_uid'); // ✅ Get stored User ID

      // ⏳ Wait for splash animation to finish
      await Future.delayed(Duration(seconds: 3));

      if (storedUID != null && storedUID.isNotEmpty) {
        Get.offAll(() => BottomNavBar()); // ✅ Navigate to Home if logged in
      } else {
        Get.offAllNamed(Routes.ONBOARD); // ✅ Navigate to Onboarding if not logged in
      }
    } catch (e) {
      print('Error checking login status: $e');
      // Fallback to onboarding on error
      Get.offAllNamed(Routes.ONBOARD);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 🎨 Change background color here
      body: Stack(
        alignment: Alignment.center,
        children: [
          /// **Background Image with Fade-in Animation**
          Positioned(
            top: 0.h,
            child: FadeIn(
              duration: Duration(seconds: 2), // 🎬 Animation duration
              child: Container(
                width: 800.w,
                height: 630.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFD19688).withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 120.w,
                    color: Color(0xFFD19688),
                  ),
                ),
              ),
            ),
          ),

          /// **Logo with Scaling Animation**
          Positioned(
            top: 650.h,
            child: AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _logoAnimation.value, // 🔄 Apply scaling animation
                  child: Container(
                    width: 170.w,
                    height: 170.h,
                    decoration: BoxDecoration(
                      color: Color(0xFFD19688),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFD19688).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 80.w,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),

          // **(Optional) Add Text or Buttons Below**
        ],
      ),
    );
  }
}
