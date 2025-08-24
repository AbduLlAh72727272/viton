import 'package:get/get.dart'; // ✅ GetX for localization
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Persistent language storage
import 'dart:ui'; // ✅ Provides Locale support

class LocalizationService extends Translations {
  /// **Supported Locales**
  static final List<Locale> locales = [
    Locale('en', 'US'), // ✅ English
    Locale('el', 'GR'), // ✅ Greek
  ];

  static const String defaultLang = 'en'; // ✅ Default language
  static const String languageKey = 'selectedLanguage'; // 🔑 Key for storing language preference

  /// **Translation Keys**
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
      'forgot_password_instruction': "Enter your email address and we'll send you a link to reset your password.",
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

      // ✅ Profile Screen
      'profile': 'Profile',
      'how_to_use': 'How To Use',
      'contact_us': 'Contact Us',
      'terms_of_service': 'Terms of Service',
      'privacy_policy': 'Privacy Policy',

      // ✅ Home Screen
      'start_here': 'Start Here',
      'import_from_gallery': 'Import from gallery',

      // ✅ Bottom Navigation Bar
      'outfits': 'Outfits',
      'try_on': 'Try On',
      'profile': 'Profile',

      // ✅ Contact Us Screen
      'get_in_touch': 'Get in Touch',
      'contact_us_info': 'contact_us_info',
      'email_us': 'Email',
      'phone': 'Phone',
      'address': 'Address',

      // ✅ Logout Screen
      'logout_title': 'Log Out',
      'logout_prompt': 'Are you sure you want to log out?',

      // ✅ Try-On Result Screen
      'try_on_result': 'Try-On Result',
      'generating': 'Generating...',
      'share_text': 'Check out my virtual try-on look! 👗✨',
      'shop_now': 'SHOP NOW',

      // How To Use screen
      'how_to_use_title': 'How To Use',
      'how_to_use_heading': 'How to Use ZINI Virtual Try-On Closet',
      'how_to_use_intro': 'Follow these simple steps to get the best experience with our app:',
      'step1_title': '1. Sign Up or Log In',
      'step1_desc': 'Create an account or log in using your existing credentials.',
      'step2_title': '2. Upload or Select an Outfit',
      'step2_desc': 'Choose an outfit from our collection.',
      'step3_title': '3. Use Virtual Try-On',
      'step3_desc': 'Tap on the "Try-On" button to see how the outfit looks on you.',
      'step5_title': '4. Save or Share',
      'step5_desc': 'Save your virtual outfit or share it with friends.',
      'step6_title': '5. Manage Preferences',
      'step6_desc': 'Go to settings to manage your profile, preferences, and privacy options.',
      'need_help_line': 'Need help? Visit our Contact Us page for support.',

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
      'forgot_password_instruction': "Εισαγάγετε το email σας και θα σας στείλουμε έναν σύνδεσμο για να επαναφέρετε τον κωδικό πρόσβασής σας.",
      'send_reset_link': 'Αποστολή συνδέσμου επαναφοράς',
      'reset_email_sent': 'Το email επαναφοράς κωδικού στάλθηκε. Ελέγξτε τα εισερχόμενά σας!',
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
      'shop_now': 'Αγορά',

      // ✅ Profile Screen
      'profile': 'Προφίλ',
      'how_to_use': 'Πως να το χρησιμοποιήσετε',
      'contact_us': 'Επικοινωνήστε μαζί μας',
      'terms_of_service': 'Όροι υπηρεσίας',
      'privacy_policy': 'Πολιτική απορρήτου',

      // ✅ Home Screen
      'start_here': 'Ξεκινήστε εδώ',
      'import_from_gallery': 'Εισαγωγή από τη συλλογή',

      // ✅ Bottom Navigation Bar
      'outfits': 'Σύνολα',
      'try_on': 'Δοκιμή',
      'profile': 'Προφίλ',

      'get_in_touch': 'Επικοινωνήστε μαζί μας',
      'contact_us_info': 'πληροφορίες_επικοινωνίας_μας.',
      'Phone': 'Τηλέφωνο',
      'address': 'Διεύθυνση',

      // How To Use screen (GR)
      'how_to_use_title': 'Οδηγίες χρήσης',
      'how_to_use_heading': 'Πώς να χρησιμοποιήσετε το ZINI Virtual Try-On Closet',
      'how_to_use_intro': 'Ακολουθήστε αυτά τα απλά βήματα για την καλύτερη εμπειρία στην εφαρμογή:',
      'step1_title': '1. Εγγραφή ή Σύνδεση',
      'step1_desc': 'Δημιουργήστε λογαριασμό ή συνδεθείτε με τα υπάρχοντα στοιχεία σας.',
      'step2_title': '2. Μεταφορτώστε ή Επιλέξτε Ένα Ρούχο',
      'step2_desc': 'Διαλέξτε ένα ρούχο από τη συλλογή μας.',
      'step3_title': '3. Εικονική Δοκιμή',
      'step3_desc': 'Πατήστε «Δοκιμή» για να δείτε πώς φαίνεται πάνω σας.',
      'step5_title': '4. Αποθήκευση ή Κοινοποίηση',
      'step5_desc': 'Αποθηκεύστε το εικονικό σας outfit ή μοιραστείτε το με φίλους.',
      'step6_title': '5. Διαχείριση Προτιμήσεων',
      'step6_desc': 'Μεταβείτε στις ρυθμίσεις για προφίλ, προτιμήσεις και απόρρητο.',
      'need_help_line': 'Χρειάζεστε βοήθεια; Επισκεφθείτε τη σελίδα «Επικοινωνία» για υποστήριξη.',


    },
  };

  /// **Get Stored Language Preference**
  Future<Locale> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(languageKey) ?? defaultLang;
    return Locale(langCode, langCode == 'el' ? 'GR' : 'US'); // ✅ Return stored language or default
  }

  /// **Save Selected Language**
  Future<void> saveLanguage(String langCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, langCode); // ✅ Store selected language
  }

  /// **Change App Language**
  void changeLocale(String langCode) async {
    Locale locale = Locale(langCode, langCode == 'el' ? 'GR' : 'US');
    await saveLanguage(langCode); // ✅ Save language in SharedPreferences
    Get.updateLocale(locale); // 🔄 Update language globally in app
  }
}
