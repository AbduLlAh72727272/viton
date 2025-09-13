import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class LocalizationService extends Translations {
  /// **Supported Locales**
  static final List<Locale> locales = [
    Locale('en', 'US'), // English
    Locale('el', 'GR'), // Greek
  ];

  /// **Default Language**
  static const String defaultLang = 'en';
  static const String languageKey = 'selectedLanguage'; // Key for SharedPreferences

  /// **All Translation Keys**
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      // ✅ Common Text
      'language': 'Language',
      'yes': 'Yes',
      'no': 'No',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',

      // ✅ Authentication Screens
      'sign_in': 'Sign In',
      'email': 'E-mail',
      'password': 'Password',
      'remember_me': 'Remember Me',
      'forgot_password': 'Forgot Password?',
      'dont_have_account': "Don't have an account?",
      'sign_up': "Sign Up",
      'already_have_account': 'Already have an account?',
      'create_account': 'Create an account',
      'account_created': 'Account created successfully!',
      'all_fields_required': 'All fields are required!',
      'invalid_email': 'Enter a valid email address!',
      'password_length': 'Password must be at least 6 characters!',

      // ✅ Forgot Password Screen
      'forgot_password_title': 'Forgot Password?',
      'forgot_password_instruction':
      "Enter your email address and we'll send you a link to reset your password.",
      'send_reset_link': 'Send Reset Link',
      'reset_email_sent': 'Password reset email sent. Check your inbox!',
      'remember_password': 'Remember your password?',

      // ✅ Onboarding Screen
      'welcome_to': 'Welcome to',
      'app_name': 'Zini Virtual Closet',
      'login': 'Login',
      'register': 'Register',

      // ✅ Admin Panel
      'admin_panel': 'Admin Panel',
      'enter_clothing_name': 'Enter Clothing Item Name',
      'upload_image': 'Upload Image',
      'select_category': 'Select Category',
      'add_clothing_item': 'Add Clothing Item',
      'log_out': 'Log Out',
      'logout_confirmation': 'Are you sure you want to log out?',

      // ✅ Home Screen
      'start_here': 'Start Here',
      'import_from_gallery': 'Import from gallery',

      // ✅ Bottom Navigation Bar
      'outfits': 'Outfits',
      'try_on': 'Try On',

      // ✅ Profile Screen
      'profile': 'Profile',
      'how_to_use': 'How To Use',
      'contact_us': 'Contact Us',
      'terms_of_service': 'Terms of Service',
      'privacy_policy': 'Privacy Policy',

      // ✅ Contact Us Screen
      'get_in_touch': 'Get in Touch',
      'contact_us_info':
      'If you have any questions or need support, feel free to reach out to us through the following channels. We are here to help!',
      'phone': 'Phone',
      'address': 'Address',
      'contact_email_value': 'customersupport@ziniboutique.com',
      'contact_phone_value': '+30 2310220443',
      'contact_address_value': 'Agelou Metaxa 24-26, Glyfada',

      // ✅ Privacy Policy Screen
      'privacy_policy_title': 'Privacy Policy',
      'privacy_policy_content': '''
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
If you have questions about this Privacy Policy, please contact us at customersupport@ziniboutique.com.

12. App Tracking Transparency
In accordance with Apple's App Tracking Transparency framework, we will request your permission before tracking your activity across other companies' apps and websites.

Terms Of Service  |  Privacy Policy  |  Contact Us
''',

      // ✅ Terms of Service Screen
      'terms_of_service_title': 'Terms of Service',
      'terms_of_service_content': '''
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
If you have any questions about these Terms, please contact us at customersupport@ziniboutique.com.

10. Governing Law
These Terms shall be governed by the laws of the State of Delaware, without regard to its conflict of law provisions.

Terms Of Service  |  Privacy Policy  |  Contact Us
''',

      // ✅ How To Use screen
      'how_to_use_title': 'How To Use',
      'how_to_use_heading': 'How to Use ZINI Virtual Try-On Closet',
      'how_to_use_intro':
      'Follow these simple steps to get the best experience with our app:',
      'step1_title': '1. Sign Up or Log In',
      'step1_desc':
      'Create an account or log in using your existing credentials.',
      'step2_title': '2. Upload or Select an Outfit',
      'step2_desc': 'Choose an outfit from our collection.',
      'step3_title': '3. Use Virtual Try-On',
      'step3_desc':
      'Tap on the "Try-On" button to see how the outfit looks on you.',
      'step5_title': '4. Save or Share',
      'step5_desc': 'Save your virtual outfit or share it with friends.',
      'step6_title': '5. Manage Preferences',
      'step6_desc':
      'Go to settings to manage your profile, preferences, and privacy options.',
      'need_help_line': 'Need help? Visit our Contact Us page for support.',

      // ✅ Logout Screen
      'logout_title': 'Log Out',
      'logout_prompt': 'Are you sure you want to log out?',

      // ✅ Try-On Result Screen
      'try_on_result': 'Try-On Result',
      'generating': 'Generating...',
      'share_text': 'Check out my virtual try-on look! 👗✨',
      'shop_now': 'SHOP NOW',
    },
    'el_GR': {
      // ✅ Common Text
      'language': 'Γλώσσα',
      'yes': 'Ναι',
      'no': 'Όχι',
      'loading': 'Φόρτωση...',
      'error': 'Σφάλμα',
      'success': 'Επιτυχία',

      // ✅ Authentication Screens
      'sign_in': 'Σύνδεση',
      'name': 'Όνομα',
      'email': 'Ηλεκτρονικό ταχυδρομείο',
      'password': 'Κωδικός πρόσβασης',
      'remember_me': 'Θυμήσου με',
      'forgot_password': 'Ξεχάσατε τον κωδικό;',
      'dont_have_account': "Δεν έχετε λογαριασμό;",
      'sign_up': "Εγγραφή",
      'already_have_account': 'Έχετε ήδη λογαριασμό;',
      'create_account': 'Δημιουργία λογαριασμού',
      'account_created': 'Ο λογαριασμός δημιουργήθηκε με επιτυχία!',
      'all_fields_required': 'Όλα τα πεδία είναι υποχρεωτικά!',
      'invalid_email': 'Εισαγάγετε μια έγκυρη διεύθυνση email!',
      'password_length': 'Ο κωδικός πρέπει να έχει τουλάχιστον 6 χαρακτήρες!',

      // ✅ Forgot Password Screen
      'forgot_password_title': 'Ξεχάσατε τον κωδικό;',
      'forgot_password_instruction':
      "Εισαγάγετε το email σας και θα σας στείλουμε έναν σύνδεσμο για να επαναφέρετε τον κωδικό πρόσβασής σας.",
      'send_reset_link': 'Αποστολή συνδέσμου επαναφοράς',
      'reset_email_sent':
      'Το email επαναφοράς κωδικού στάλθηκε. Ελέγξτε τα εισερχόμενά σας!',
      'remember_password': 'Θυμηθήκατε τον κωδικό σας;',

      // ✅ Onboarding Screen
      'welcome_to': 'Καλώς ήρθατε στο',
      'app_name': 'Zini Virtual Closet',
      'login': 'Σύνδεση',
      'register': 'Εγγραφή',

      // ✅ Admin Panel
      'admin_panel': 'Πίνακας Διαχείρισης',
      'enter_clothing_name': 'Εισαγάγετε το όνομα του ρούχου',
      'upload_image': 'Μεταφόρτωση εικόνας',
      'select_category': 'Επιλέξτε κατηγορία',
      'add_clothing_item': 'Προσθήκη ρούχου',
      'log_out': 'Αποσύνδεση',
      'logout_confirmation': 'Είστε σίγουροι ότι θέλετε να αποσυνδεθείτε;',

      // ✅ Home Screen
      'start_here': 'Ξεκινήστε εδώ',
      'import_from_gallery': 'Εισαγωγή από τη συλλογή',

      // ✅ Bottom Navigation Bar
      'outfits': 'Σύνολα',
      'try_on': 'Δοκιμή',

      // ✅ Profile Screen
      'profile': 'Προφίλ',
      'how_to_use': 'Πως να το χρησιμοποιήσετε',
      'contact_us': 'Επικοινωνήστε μαζί μας',
      'terms_of_service': 'Όροι υπηρεσίας',
      'privacy_policy': 'Πολιτική Απορρήτου',

      // ✅ Contact Us Screen
      'get_in_touch': 'Επικοινωνήστε μαζί μας',
      'contact_us_info':
      'Εάν έχετε ερωτήσεις ή χρειάζεστε υποστήριξη, μη διστάσετε να επικοινωνήσετε μαζί μας μέσω των παρακάτω καναλιών. Είμαστε εδώ για να βοηθήσουμε!',
      'phone': 'Τηλέφωνο',
      'address': 'Διεύθυνση',
      'contact_email_value': 'customersupport@ziniboutique.com',
      'contact_phone_value': '+30 2310220443',
      'contact_address_value': 'Αγγέλου Μεταξά 24-26, Γλυφάδα',

      // ✅ Privacy Policy Screen
      'privacy_policy_title': 'Πολιτική Απορρήτου',
      'privacy_policy_content': '''
ZINI Virtual Try-On Closet – Πολιτική Απορρήτου

Τελευταία ενημέρωση: 9 Νοεμβρίου 2024
Η παρούσα Πολιτική Απορρήτου περιγράφει πώς η εφαρμογή ZINI Virtual Try-On Closet («εμείς», «μας» ή «δικό μας») συλλέγει, χρησιμοποιεί και κοινοποιεί τα προσωπικά σας δεδομένα όταν χρησιμοποιείτε την κινητή εφαρμογή μας (η «Εφαρμογή»).

1. Πληροφορίες που Συλλέγουμε
Συλλέγουμε διάφορους τύπους δεδομένων από και για τους χρήστες της Εφαρμογής, όπως:
• Προσωπικές πληροφορίες που παρέχετε (π.χ. διεύθυνση email όταν επικοινωνείτε με την υποστήριξη)
• Δεδομένα χρήσης (πώς αλληλεπιδράτε με την Εφαρμογή)
• Ιστορικό συνομιλιών και αλληλεπιδράσεις με την ΤΝ μας
• Πληροφορίες συσκευής (τύπος συσκευής, έκδοση λειτουργικού συστήματος)
• Πληροφορίες συνδρομής και συναλλαγών

2. Πώς Χρησιμοποιούμε τα Δεδομένα σας
Χρησιμοποιούμε τις πληροφορίες που συλλέγουμε για να:
• Παρέχουμε και να διατηρούμε την Εφαρμογή
• Επεξεργαζόμαστε τις συνδρομές και τις συναλλαγές σας
• Βελτιώνουμε και εξατομικεύουμε την εμπειρία σας
• Αναπτύσσουμε νέες λειτουργίες και υπηρεσίες
• Σας στέλνουμε τεχνικές ειδοποιήσεις και μηνύματα υποστήριξης
• Εντοπίζουμε και αποτρέπουμε απάτη ή κακή χρήση

3. Αποθήκευση και Ασφάλεια Δεδομένων
Εφαρμόζουμε κατάλληλα τεχνικά και οργανωτικά μέτρα για την προστασία των προσωπικών σας δεδομένων. Ωστόσο, καμία μέθοδος μετάδοσης μέσω διαδικτύου ή ηλεκτρονικής αποθήκευσης δεν είναι 100% ασφαλής.

4. Χρήση Δεδομένων για Εκπαίδευση ΤΝ
Οι συνομιλίες σας με την ΤΝ μας ενδέχεται να χρησιμοποιηθούν για τη βελτίωση των μοντέλων και των υπηρεσιών μας. Τα δεδομένα ανωνυμοποιούνται και συγκεντρώνονται ώστε να προστατεύεται η ιδιωτικότητά σας. Μπορείτε να διαγράψετε το ιστορικό συνομιλιών σας οποιαδήποτε στιγμή μέσω της Εφαρμογής.

5. Κοινοποίηση και Διαβίβαση Δεδομένων
Δεν πουλάμε τα προσωπικά σας δεδομένα. Μπορεί να τα κοινοποιήσουμε σε:
• Παρόχους υπηρεσιών που μας βοηθούν στη λειτουργία της Εφαρμογής
• Αρχές επιβολής του νόμου, όπου απαιτείται από τον νόμο
• Τρίτους, στο πλαίσιο επιχειρηματικής μεταβίβασης

6. Τα Δικαιώματά σας
Έχετε το δικαίωμα να:
• Έχετε πρόσβαση στα προσωπικά σας δεδομένα
• Διαγράψετε τον λογαριασμό και τα δεδομένα σας
• Απενεργοποιήσετε την αποστολή διαφημιστικών/προωθητικών μηνυμάτων
• Ελέγχετε τα δικαιώματα της Εφαρμογής μέσω των ρυθμίσεων της συσκευής σας

7. Απόρρητο Ανηλίκων
Η Εφαρμογή δεν προορίζεται για παιδιά κάτω των 13 ετών. Δεν συλλέγουμε εν γνώσει μας δεδομένα από παιδιά κάτω των 13.

8. Διεθνείς Μεταφορές Δεδομένων
Τα δεδομένα σας ενδέχεται να μεταφερθούν και να υποβληθούν σε επεξεργασία σε χώρες εκτός της δικής σας. Διασφαλίζουμε ότι εφαρμόζονται οι κατάλληλες εγγυήσεις για τέτοιες μεταφορές.

9. Αλλαγές στην Πολιτική
Η Πολιτική Απορρήτου μπορεί να ενημερώνεται περιοδικά. Θα σας ενημερώνουμε για τυχόν αλλαγές αναρτώντας τη νέα Πολιτική σε αυτή τη σελίδα και ανανεώνοντας την ένδειξη «Τελευταία ενημέρωση».

10. Δικαιώματα στην Καλιφόρνια
Οι κάτοικοι της Καλιφόρνια έχουν ορισμένα δικαιώματα σχετικά με τα προσωπικά τους δεδομένα σύμφωνα με τον νόμο CCPA. Επικοινωνήστε μαζί μας για να τα ασκήσετε.

11. Επικοινωνία
Για ερωτήσεις σχετικά με την παρούσα Πολιτική Απορρήτου, επικοινωνήστε μαζί μας στο customersupport@ziniboutique.com

12. Διαφάνεια Παρακολούθησης Εφαρμογών
Σύμφωνα με το πλαίσιο App Tracking Transparency της Apple, θα ζητούμε τη συγκατάθεσή σας πριν παρακολουθήσουμε τη δραστηριότητά σας σε εφαρμογές και ιστότοπους άλλων εταιρειών.
''',
      // ✅ Terms of Service Screen
      'terms_of_service_title': 'Όροι Χρήσης',
      'terms_of_service_content': '''
ZINI Virtual Try-On Closet – Όροι Χρήσης

Τελευταία ενημέρωση: 9 Νοεμβρίου 2024
Καλώς ήρθατε στο ZINI Virtual Try-On Closet. Παρακαλούμε διαβάστε προσεκτικά τους παρόντες Όρους Χρήσης («Όροι») πριν χρησιμοποιήσετε την κινητή εφαρμογή μας («Εφαρμογή»), η οποία λειτουργεί από την ZINI Virtual Try-On Closet («εμείς», «μας» ή «δικό μας»).
Με τη λήψη, πρόσβαση ή χρήση της Εφαρμογής, συμφωνείτε ότι δεσμεύεστε από αυτούς τους Όρους. Αν δεν συμφωνείτε με οποιοδήποτε μέρος των Όρων, τότε δεν επιτρέπεται να έχετε πρόσβαση ή να χρησιμοποιείτε την Εφαρμογή.

1. Όροι Συνδρομής
Η Εφαρμογή μας προσφέρει επιλογές συνδρομής με αυτόματη ανανέωση.
• Η πληρωμή θα χρεωθεί στον λογαριασμό Apple ID σας κατά την επιβεβαίωση της αγοράς.
• Η συνδρομή σας ανανεώνεται αυτόματα εκτός αν ακυρωθεί τουλάχιστον 24 ώρες πριν από το τέλος της τρέχουσας περιόδου.
• Ο λογαριασμός σας θα χρεωθεί για ανανέωση εντός 24 ωρών πριν από το τέλος της τρέχουσας περιόδου.
• Μπορείτε να διαχειριστείτε και να ακυρώσετε τις συνδρομές σας από τις ρυθμίσεις λογαριασμού στο App Store.

2. Άδεια Χρήσης
Σας χορηγούμε περιορισμένη, μη μεταβιβάσιμη και μη αποκλειστική άδεια χρήσης της Εφαρμογής για προσωπικούς και μη εμπορικούς σκοπούς. Δεν επιτρέπεται να:
• Τροποποιείτε ή δημιουργείτε παράγωγα έργα βασισμένα στην Εφαρμογή
• Αντιγράφετε, διανέμετε ή μεταβιβάζετε την Εφαρμογή ή μέρος αυτής
• Κάνετε αντίστροφη μηχανική, αποσυμπίληση ή προσπάθεια εξαγωγής του πηγαίου κώδικα
• Αφαιρείτε οποιαδήποτε ειδοποίηση πνευματικών δικαιωμάτων ή άλλων ιδιοκτησιακών δικαιωμάτων

3. Περιεχόμενο Χρήστη
Είστε υπεύθυνοι για κάθε περιεχόμενο ή πληροφορία που παρέχετε μέσω της Εφαρμογής. Συμφωνείτε να μην χρησιμοποιείτε την Εφαρμογή για:
• Παραβίαση νόμων
• Ανάρτηση μη εξουσιοδοτημένων εμπορικών επικοινωνιών
• Μεταφόρτωση ιών ή κακόβουλου κώδικα
• Παρενόχληση, εκφοβισμό ή εκφοβιστική συμπεριφορά προς άλλους χρήστες
• Ανάρτηση περιεχομένου που αποτελεί ρητορική μίσους, απειλητικό, πορνογραφικό, υποκινεί βία ή περιλαμβάνει γυμνότητα/γραφική βία

4. Αλληλεπιδράσεις με Τεχνητή Νοημοσύνη
Η Εφαρμογή χρησιμοποιεί τεχνητή νοημοσύνη για να δημιουργεί απαντήσεις και να αλληλεπιδρά με τους χρήστες. Παρόλο που προσπαθούμε να παρέχουμε χρήσιμες και κατάλληλες απαντήσεις, δεν εγγυόμαστε την ακρίβεια, πληρότητα ή καταλληλότητα του παραγόμενου περιεχομένου.
Η ΤΝ δεν αποτελεί υποκατάστατο επαγγελματικών συμβουλών (ιατρικών, νομικών, οικονομικών κ.λπ.) και δεν πρέπει να βασίζεστε σε αυτήν για τέτοια ζητήματα.

5. Απόρρητο
Η ιδιωτικότητά σας είναι σημαντική για εμάς. Η Πολιτική Απορρήτου μας εξηγεί πώς συλλέγουμε, χρησιμοποιούμε και προστατεύουμε τις πληροφορίες σας κατά τη χρήση της Εφαρμογής. Με τη χρήση της Εφαρμογής, αποδέχεστε τη συλλογή και χρήση δεδομένων σύμφωνα με την Πολιτική Απορρήτου.

6. Αποποίηση Εγγυήσεων
Η Εφαρμογή παρέχεται «ΩΣ ΕΧΕΙ» και «ΩΣ ΔΙΑΤΙΘΕΤΑΙ», χωρίς καμία εγγύηση οποιουδήποτε είδους. Δεν εγγυόμαστε ότι η Εφαρμογή θα είναι αδιάλειπτη ή χωρίς σφάλματα.

7. Περιορισμός Ευθύνης
Στο μέγιστο επιτρεπτό από τον νόμο βαθμό, η ZINI Virtual Try-On Closet AI LLC δεν ευθύνεται για έμμεσες, παρεπόμενες, ειδικές, αποθετικές ή τιμωρητικές ζημίες που προκύπτουν από τη χρήση της Εφαρμογής.

8. Τροποποιήσεις Όρων
Διατηρούμε το δικαίωμα να τροποποιήσουμε ή να αντικαταστήσουμε αυτούς τους Όρους οποιαδήποτε στιγμή. Αν η αλλαγή είναι ουσιώδης, θα σας παρέχουμε ειδοποίηση τουλάχιστον 30 ημέρες πριν από την έναρξη ισχύος των νέων όρων.

9. Επικοινωνία
Για ερωτήσεις σχετικά με τους παρόντες Όρους, επικοινωνήστε μαζί μας στο customersupport@ziniboutique.com

10. Εφαρμοστέο Δίκαιο
Οι Όροι διέπονται από τη νομοθεσία.
''',
      // ✅ How To Use screen (GR)
      'how_to_use_title': 'Οδηγίες χρήσης',
      'how_to_use_heading':
      'Πώς να χρησιμοποιήσετε το ZINI Virtual Try-On Closet',
      'how_to_use_intro':
      'Ακολουθήστε αυτά τα απλά βήματα για την καλύτερη εμπειρία στην εφαρμογή:',
      'step1_title': '1. Εγγραφή ή Σύνδεση',
      'step1_desc':
      'Δημιουργήστε λογαριασμό ή συνδεθείτε με τα υπάρχοντα στοιχεία σας.',
      'step2_title': '2. Μεταφορτώστε ή Επιλέξτε Ένα Ρούχο',
      'step2_desc': 'Διαλέξτε ένα ρούχο από τη συλλογή μας.',
      'step3_title': '3. Εικονική Δοκιμή',
      'step3_desc': 'Πατήστε «Δοκιμή» για να δείτε πώς φαίνεται πάνω σας.',
      'step5_title': '4. Αποθήκευση ή Κοινοποίηση',
      'step5_desc':
      'Αποθηκεύστε το εικονικό σας outfit ή μοιραστείτε το με φίλους.',
      'step6_title': '5. Διαχείριση Προτιμήσεων',
      'step6_desc':
      'Μεταβείτε στις ρυθμίσεις για προφίλ, προτιμήσεις και απόρρητο.',
      'need_help_line':
      'Χρειάζεστε βοήθεια; Επισκεφθείτε τη σελίδα «Επικοινωνία» για υποστήριξη.',

      // ✅ Try-On Result Screen
      'shop_now': 'Αγορά',
    },
  };

  /// **Get Stored Language Preference**
  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(languageKey) ?? defaultLang;
    return Locale(langCode, langCode == 'el' ? 'GR' : 'US');
  }

  /// **Save Selected Language**
  Future<void> saveLanguage(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, langCode);
  }

  /// **Change App Language**
  void changeLocale(String langCode) async {
    Locale locale = Locale(langCode, langCode == 'el' ? 'GR' : 'US');
    await saveLanguage(langCode);
    Get.updateLocale(locale);
  }
}

