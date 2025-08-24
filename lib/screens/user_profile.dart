import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/privacy_policy.dart';
import '../screens/terms_of_services.dart';
import 'contact_us.dart';
import 'how_to_use.dart';
import '../screens/signin_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "profile".tr, // ✅ Localized title
          style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                _buildListTile(Icons.lightbulb_outline, "how_to_use".tr, HowToUseScreen()),
                _buildListTile(Icons.mail_outline, "contact_us".tr, ContactUsScreen()),
                _buildListTile(Icons.description, "terms_of_service".tr, TermsOfServiceScreen()),
                _buildListTile(Icons.description_outlined, "privacy_policy".tr, PrivacyPolicyScreen()),

                // Logout Button
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text(
                    "log_out".tr, // ✅ Localized text
                    style: TextStyle(fontSize: 16.sp, color: Colors.red),
                  ),
                  onTap: () => _showLogoutConfirmation(context), // Show confirmation dialog
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Version Information at the bottom
            Center(
              child: Text(
                "app_version".tr, // ✅ Localized version text
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable ListTile widget with Navigation
  Widget _buildListTile(IconData icon, String title, Widget screen) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontSize: 16.sp, color: Colors.black)),
      onTap: () => Get.to(() => screen), // Navigate to respective screen
    );
  }

  // Show logout confirmation dialog
  void _showLogoutConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: "log_out".tr,
      middleText: "logout_confirmation".tr, // ✅ Localized text
      textConfirm: "yes".tr,
      textCancel: "no".tr,
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () => _logoutUser(),
    );
  }

  // Function to log out the user
  Future<void> _logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_uid'); // Remove stored UID
    Get.offAll(() => SignInScreen()); // Redirect to Sign In screen
  }
}
