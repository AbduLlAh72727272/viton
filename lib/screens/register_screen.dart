import 'package:flutter/material.dart';
import 'package:get/get.dart'; // ✅ GetX for localization & navigation
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart'; // ✅ Firebase Authentication
import 'package:email_validator/email_validator.dart'; // 📧 Email validation package
import '../routes/app_routes.dart'; // ✅ Route management

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // ✅ Firebase instance
  bool _obscurePassword = true; // ✅ Password visibility toggle

  final TextEditingController _nameController = TextEditingController(); // 📝 Name input
  final TextEditingController _emailController = TextEditingController(); // 📧 Email input
  final TextEditingController _passwordController = TextEditingController(); // 🔒 Password input

  bool _isLoading = false; // 🔄 Loading state for button

  /// **Validates Email Format**
  bool _isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  /// **Handles User Registration with Firebase**
  Future<void> _registerUser() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // ✅ Basic Validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("error".tr, "all_fields_required".tr,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // ✅ Email Format Validation
    if (!_isValidEmail(email)) {
      Get.snackbar("error".tr, "invalid_email".tr,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // ✅ Password Length Validation
    if (password.length < 6) {
      Get.snackbar("error".tr, "password_length".tr,
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      setState(() => _isLoading = true); // 🔄 Show loading state

      // 🔥 Firebase Authentication: Register User
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name); // 📝 Update user name in Firebase
        await user.reload();

        // ✅ Success message & navigate to login screen
        Get.snackbar("success".tr, "account_created".tr,
            backgroundColor: Colors.green, colorText: Colors.white);

        Get.offNamed(Routes.LOGIN);
      }
    } catch (e) {
      // ❌ Firebase Authentication Error Handling
      Get.snackbar("error".tr, e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      setState(() => _isLoading = false); // 🔄 Hide loading state
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Title: Sign Up**
              Text(
                "sign_up".tr, // ✅ Localized text (Modify in translation files)
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),

              /// **Name Input Field**
              _buildTextField(controller: _nameController, label: "name".tr, hint: "John Doe"),
              SizedBox(height: 15.h),

              /// **Email Input Field**
              _buildTextField(controller: _emailController, label: "email".tr, hint: "example@gmail.com"),
              SizedBox(height: 15.h),

              /// **Password Input Field (With Visibility Toggle)**
              _buildTextField(
                controller: _passwordController,
                label: "password".tr, // ✅ Localized label
                hint: "********", // 🔒 Hide password
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword; // 🔄 Toggle password visibility
                    });
                  },
                ),
              ),

              SizedBox(height: 30.h),

              /// **Sign Up Button**
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _registerUser, // 🔄 Disable when loading
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // 🎨 Button color
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white) // 🔄 Show loading spinner
                      : Text("sign_up".tr, style: TextStyle(fontSize: 18.sp)),
                ),
              ),

              SizedBox(height: 20.h),

              /// **Already Have an Account? Sign In**
              Center(
                child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.LOGIN), // ✅ Navigate to login
                  child: Text.rich(
                    TextSpan(
                      text: "already_have_account".tr + " ", // ✅ Localized text
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "sign_in".tr, // ✅ Localized "Sign in"
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
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
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5.h),

        /// **Input Field**
        TextField(
          controller: controller,
          obscureText: obscureText, // 🔒 Hide password if required
          decoration: InputDecoration(
            hintText: hint, // 📧 Placeholder text
            filled: true,
            fillColor: Colors.grey[200], // 🎨 Background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon, // 🔄 Optional visibility toggle
          ),
        ),
      ],
    );
  }
}
