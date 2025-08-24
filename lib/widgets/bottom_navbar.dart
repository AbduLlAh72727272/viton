import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // ✅ Custom bottom navigation
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ GetX for localization
import 'package:viton/screens/outfit.dart'; // ✅ Import Try-On screen
import '../screens/home_screen.dart'; // ✅ Import Home screen
import '../screens/user_profile.dart'; // ✅ Import User Profile screen

void main() => runApp(MaterialApp(home: BottomNavBar())); // 🚀 Launch the app with BottomNavBar

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0; // ✅ Current selected page index
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey(); // 🔑 Key for navigation bar

  /// **List of Screens**
  final List<Widget> _screens = [
    TryOnScreen(userImagePath: ''), // ✅ Try-On Screen
    HomeScreen(), // ✅ Home Screen
    ProfileScreen(), // ✅ Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// **Bottom Navigation Bar**
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page, // 🔄 Keep track of selected page
        height: 50.h, // 📏 Navigation bar height
        items: <Widget>[
          _buildNavItem('assets/icons/outfit.png', "outfits".tr), // ✅ Outfits Tab
          _buildNavItem('assets/icons/tryon.png', "try_on".tr), // ✅ Try-On Tab
          _buildNavItem('assets/icons/user_profile.png', "profile".tr), // ✅ Profile Tab
        ],
        color: Colors.transparent.withOpacity(0.1), // 🎨 Transparent background
        buttonBackgroundColor: Color(0xFFcd8e7e), // 🎨 Button color
        backgroundColor: Colors.transparent, // 🎨 Overall background
        animationCurve: Curves.easeInOut, // 🎬 Smooth animation
        animationDuration: Duration(milliseconds: 500), // ⏳ Animation speed
        onTap: (index) {
          setState(() {
            _page = index; // 🔄 Update selected page
          });
        },
      ),

      /// **Display the selected screen**
      body: _screens[_page], // 🔄 Show the selected screen based on _page index
    );
  }

  /// **Reusable Function to Build Navigation Items**
  Widget _buildNavItem(String iconPath, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(iconPath, width: 25.w, height: 25.h), // 🖼 Icon
        SizedBox(height: 2.h),
        Text(
          label, // 🔤 Localized text
          style: TextStyle(fontSize: 10.sp, color: Colors.black),
        ),
      ],
    );
  }
}
