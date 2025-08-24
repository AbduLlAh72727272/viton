import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ GetX for navigation & localization
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase authentication for password reset

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // ✅ Firebase instance
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // ✅ Loading state for button

  /// Sends a password reset email
  Future<void> _resetPassword() async {
    String email = _emailController.text.trim(); // ✅ Get email from input field

    if (email.isEmpty) {
      // ❌ Show error if email is empty
      Get.snackbar("error".tr, "all_fields_required".tr,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      setState(() => _isLoading = true); // 🔄 Show loading state
      await _auth.sendPasswordResetEmail(email: email); // 📧 Firebase reset email
      Get.snackbar("success".tr, "reset_email_sent".tr,
          backgroundColor: Colors.green, colorText: Colors.white);

      // ✅ Go back after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
    } catch (e) {
      // ❌ Show error message from Firebase
      Get.snackbar("error".tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => _isLoading = false); // 🔄 Remove loading state
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(), // 🔄 Navigate back
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Title: "Forgot Password?"**
            Text(
              "forgot_password_title".tr, // ✅ Localized text
              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),

            /// **Subtitle: "Enter your email, we'll send a reset link"**
            Text(
              "forgot_password_instruction".tr, // ✅ Localized text
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            /// **Email Input Field**
            _buildTextField(
                controller: _emailController,
                label: "email".tr, // ✅ Localized label
                hint: "example@gmail.com"), // 📧 Change placeholder if needed

            SizedBox(height: 30.h),

            /// **Reset Password Button**
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _resetPassword, // 🔄 Disable button when loading
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // 🎨 Change button color here
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white) // 🔄 Show loading spinner
                    : Text("send_reset_link".tr, // ✅ Localized button text
                    style: TextStyle(fontSize: 18.sp)),
              ),
            ),

            SizedBox(height: 20.h),

            /// **"Remember your password? Sign in"**
            Center(
              child: GestureDetector(
                onTap: () => Get.back(), // 🔄 Navigate back to Sign-in screen
                child: Text.rich(
                  TextSpan(
                    text: "remember_password".tr + " ", // ✅ Localized text
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: "sign_in".tr, // ✅ Localized "Sign in"
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
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

  /// **Reusable Text Field Widget for Email Input**
  Widget _buildTextField(
      {required TextEditingController controller,
        required String label,
        required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, // 🔤 Localized label text (e.g., "Email")
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500)),
        SizedBox(height: 5.h),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: hint, // ✏️ Placeholder text
            filled: true,
            fillColor: Colors.grey[200], // 🎨 Background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
