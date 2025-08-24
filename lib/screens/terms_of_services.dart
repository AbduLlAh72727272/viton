import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          "Terms of Service",
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
                      _termsOfServiceText,
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

  final String _termsOfServiceText = '''
TERMS OF SERVICE

ZINI Virtual Try-On Closet Terms of Service
Last updated: November 9, 2024

Welcome to ZINI Virtual Try-On Closet. Please read these Terms of Service ("Terms") carefully before using the ZINI Virtual Try-On Closet mobile application (the "App") operated by ZINI Virtual Try-On Closet ("us", "we", or "our").

By downloading, accessing, or using our App, you agree to be bound by these Terms. If you disagree with any part of the Terms, then you may not access or use our App.

1. Subscription Terms
Our App offers auto-renewing subscription options. Payment will be charged to your Apple ID account at the confirmation of purchase. Your subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. Your account will be charged for renewal within 24 hours prior to the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the App Store.

2. Use License
We grant you a limited, non-transferable, non-exclusive license to use the App for your personal, non-commercial purposes. You may not:
• Modify or create derivative works based on the App.
• Copy, distribute, or transfer the App or portions thereof.
• Reverse engineer, attempt to extract the source code of, or decompile the App.
• Remove any copyright or other proprietary notices from the App.

3. User Content
You are responsible for all content and information you provide through the App. You agree not to use the App to:
• Violate any laws.
• Post unauthorized commercial communications.
• Upload viruses or malicious code.
• Harass, bully, or intimidate any user.
• Post content that is hate speech, threatening, or pornographic; incites violence; or contains nudity or graphic violence.

4. AI Interactions
The App uses artificial intelligence to generate responses and interact with users. While we strive to provide helpful and appropriate responses, we do not guarantee the accuracy, completeness, or appropriateness of AI-generated content. The AI is not a substitute for professional advice, and you should not rely on it for medical, legal, financial, or other professional guidance.

5. Privacy
Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your information when you use our App. By using the App, you agree to the collection and use of information in accordance with our Privacy Policy.

6. Disclaimer
THE APP IS PROVIDED "AS IS" AND "AS AVAILABLE" WITHOUT WARRANTIES OF ANY KIND. WE DO NOT WARRANT THAT THE APP WILL BE UNINTERRUPTED OR ERROR-FREE.

7. Limitation of Liability
TO THE MAXIMUM EXTENT PERMITTED BY LAW, ZINI Virtual Try-On Closet AI LLC SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES ARISING FROM YOUR USE OF THE APP.

8. Changes to Terms
We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.

9. Contact Us
If you have any questions about these Terms, please contact us at info@kkk.ccom.

10. Governing Law
These Terms shall be governed by the laws of the State of Delaware, without regard to its conflict of law provisions.

Terms Of Service  |  Privacy Policy  |  Contact Us
''';
}
