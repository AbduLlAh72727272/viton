import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation
import 'package:viton/screens/virtual_tryon_tips.dart'; // ✅ Navigation to Try-On Tips screen
import '../widgets/image_picker_widget.dart';
import '../widgets/custom_button.dart';
import '../core/responsive_helper.dart'; // ✅ Responsive design utilities
import 'outfit.dart'; // ✅ Navigation to outfit screen

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userImagePath; // ✅ Stores the user's selected image path

  /// **Updates userImagePath when a new image is selected**
  void setUserImage(String path) {
    setState(() {
      userImagePath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD19688), // 🎨 Change background color here
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// **Background Image**
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Image.asset(
              'assets/images/home.jpg', // 🖼 Change background image here
              fit: BoxFit.fitWidth,
            ),
          ),

          /// **Main Content**
          SafeArea(
            child: Padding(
              padding: ResponsiveHelper.getResponsivePadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(30)),

                  /// **Localized "Start Here" Text**
                  Text(
                    "start_here".tr, // ✅ Localized text (change in translation file)
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(24), // 📏 Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // 🎨 Change text color here
                    ),
                  ),

                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(550)), // 🏗 Adjust spacing based on UI design

                  /// **Import Image Button**
                  CustomButton(
                    text: 'import_from_gallery'.tr, // ✅ Localized button text
                    onPressed: () {
                      Get.to(() => VirtualTryOnTips()); // 🔄 Navigate to Try-On Tips screen
                    },
                    backgroundColor: Colors.transparent, // 🎨 Button background
                    borderColor: Color(0xFFcd8e7e), // 🎨 Border color
                    textColor: Color(0xFFcd8e7e), // 🎨 Text color
                  ),

                  SizedBox(height: ResponsiveHelper.getResponsiveSpacing(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
