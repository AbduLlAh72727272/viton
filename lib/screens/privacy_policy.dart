import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
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
          "Privacy Policy",
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
                      _privacyPolicyText,
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

  final String _privacyPolicyText = '''
PRIVACY POLICY

ZINI Virtual Try-On Closet privacy policy.
Last updated: November 9, 2024

This Privacy Policy describes how ZINI Virtual Try-On Closet ('we', 'our', or 'us') collects, uses, and shares your personal information when you use our ZINI Virtual Try-On Closet mobile application (the "App").

1. Information We Collect
We collect several types of information from and about users of our App, including:
• Personal information you provide (such as email address when you contact support)
• Usage data (how you interact with the App)
• Chat history and interactions with our AI
• Device information (device type, operating system version)
• Subscription and transaction information

2. How We Use Your Information
We use the information we collect to:
• Provide and maintain the App
• Process your subscriptions and transactions
• Improve and personalize your experience
• Develop new features and services
• Send you technical notices and support messages
• Detect and prevent fraud or abuse

3. Data Storage and Security
We implement appropriate technical and organizational measures to protect your personal information. However, no method of transmission over the internet or electronic storage is 100% secure.

4. AI Training and Data Usage
Your conversations with our AI may be used to improve our AI models and services. We anonymize and aggregate this data to protect your privacy. You can delete your chat history at any time through the App.

5. Data Sharing and Disclosure
We do not sell your personal information. We may share your information with:
• Service providers who assist in operating our App
• Law enforcement when required by law
• Third parties in connection with a business transfer

6. Your Rights and Choices
You have the right to:
• Access your personal information
• Delete your account and data
• Opt-out of marketing communications
• Control app permissions through your device settings

7. Children's Privacy
The App is not intended for children under 13. We do not knowingly collect information from children under 13.

8. International Data Transfers
Your information may be transferred to and processed in countries other than your own. We ensure appropriate safeguards are in place for such transfers.

9. Changes to This Policy
We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.

10. California Privacy Rights
California residents have certain rights regarding their personal information under the CCPA. Please contact us to exercise these rights.

11. Contact Us
If you have questions about this Privacy Policy, please contact us at INFO@MMMM.CCOM.

12. App Tracking Transparency
In accordance with Apple's App Tracking Transparency framework, we will request your permission before tracking your activity across other companies' apps and websites.

Terms Of Service  |  Privacy Policy  |  Contact Us
''';
}
