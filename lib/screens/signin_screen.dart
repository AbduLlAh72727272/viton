import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔥 Firebase Authentication
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Remember Me feature
import '../routes/app_routes.dart'; // 🔄 App navigation routes
import '../widgets/bottom_navbar.dart'; // ✅ User Navigation
import '../core/responsive_helper.dart'; // ✅ Responsive design utilities
import 'admin_screen.dart'; // 🛠️ Admin panel
import 'ForgetPasswordScreen.dart'; // 🔑 Forgot password screen
import '../localization_service.dart'; // 🌍 Localization support

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // 🔥 Firebase instance
  bool _obscurePassword = true; // ✅ Toggle password visibility
  bool _rememberMe = false; // ✅ Remember Me checkbox

  final TextEditingController _emailController = TextEditingController(); // 📧 Email input
  final TextEditingController _passwordController = TextEditingController(); // 🔒 Password input

  bool _isLoading = false; // 🔄 Loading state
  final String adminEmail = "mapj8420@yahoo.com"; // 👨‍💼 Admin email
  final LocalizationService localizationService = LocalizationService(); // 🌍 Language support

  /// **Handles User Login with Firebase**
  Future<void> _signInUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // ✅ Basic Validation
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please enter email and password",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      setState(() => _isLoading = true); // 🔄 Show loading indicator

      // 🔥 Firebase Authentication: Sign In User
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        if (_rememberMe) {
          await _saveUserUID(user.uid); // ✅ Save login session if Remember Me is checked
        }

        // 👨‍💼 Admin vs. User Redirection
        if (email == adminEmail) {
          Get.offAll(() => AdminPanelScreen()); // ✅ Navigate to Admin Panel
        } else {
          Get.offAll(() => BottomNavBar()); // ✅ Navigate to User Dashboard
        }

        // ✅ Success Message
        Get.snackbar("Success", "Logged in successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      // ❌ Firebase Authentication Error Handling
      Get.snackbar("Login Failed", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => _isLoading = false); // 🔄 Hide loading indicator
    }
  }

  /// **Save User UID for "Remember Me" Functionality**
  Future<void> _saveUserUID(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_uid', uid);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Title: Sign In**
              Text(
                "sign_in".tr, // ✅ Localized text (Modify in translation files)
                style: TextStyle(
                  fontSize: ResponsiveHelper.getResponsiveFontSize(28), 
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(30)),

              /// **Email Input Field**
              _buildTextField(controller: _emailController, label: "email".tr, hint: "example@gmail.com"),
              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(15)),

              /// **Password Input Field (With Visibility Toggle)**
              _buildTextField(
                controller: _passwordController,
                label: "password".tr,
                hint: "********",
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                    size: ResponsiveHelper.getResponsiveIconSize(20),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // 🔄 Toggle password visibility
                    });
                  },
                ),
              ),

              SizedBox(height: ResponsiveHelper.getResponsiveSpacing(10)),

              /// **Remember Me & Forgot Password**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text("remember_me".tr), // ✅ Localized text
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => ForgotPasswordScreen()), // 🔄 Navigate to Forgot Password
                    child: Text(
                      "forgot_password".tr, // ✅ Localized text
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              /// **Sign In Button**
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signInUser, // 🔄 Disable when loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 🎨 Button color
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white) // 🔄 Show loading spinner
                      : Text("sign_in".tr, style: TextStyle(fontSize: 18.sp)),
                ),
              ),

              SizedBox(height: 20.h),

              /// **Don't Have an Account? Sign Up**
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.SIGNUP), // ✅ Navigate to Sign-Up
                  child: Text.rich(
                    TextSpan(
                      text: "dont_have_account".tr + " ", // ✅ Localized text
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "sign_up".tr, // ✅ Localized "Sign up"
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable Text Field Widget**
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Label**
        Text(
          label, // ✅ Localized label
          style: TextStyle(
            fontSize: ResponsiveHelper.getResponsiveFontSize(16), 
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: ResponsiveHelper.getResponsiveSpacing(5)),

        /// **Input Field**
        TextField(
          controller: controller,
          obscureText: obscureText, // 🔒 Hide password if required
          decoration: ResponsiveHelper.getResponsiveTextFieldDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
          ).copyWith(
            filled: true,
            fillColor: ResponsiveHelper.isIOS ? Colors.grey.shade50 : Colors.grey.shade200,
          ),
        ),
      ],
    );
  }
}
