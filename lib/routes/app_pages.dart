import 'package:get/get.dart';
import '../screens/admin_screen.dart';
import '../screens/home_screen.dart';
import '../screens/image_posting.dart';
import '../screens/onboard.dart';
import '../screens/register_screen.dart';
import '../screens/signin_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/outfit.dart';
import '../controllers/clothes_controller.dart';
import '../screens/user_profile.dart';
import '../screens/virtual_tryon_tips.dart';
import '../widgets/bottom_navbar.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => SplashScreen()),
    GetPage(name: Routes.ONBOARD, page: () => OnboardingScreen()),
    GetPage(name: Routes.SIGNUP , page: ()=> RegisterScreen()),
    GetPage(name: Routes.LOGIN, page: () => SignInScreen()),
    GetPage(name: Routes.BOTTOM_NAVIGATION, page: () => BottomNavBar()),
    GetPage(name: Routes.VirtualTryOnTips, page: () => VirtualTryOnTips()),
    GetPage(name: Routes.ImagePosting, page: () => ImagePosting()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
    GetPage(name: Routes.USERPROFILE,page: ()=> ProfileScreen()),
    GetPage(name: Routes.TRY_ON, page: () => TryOnScreen(userImagePath: Get.arguments),),
    GetPage(name: Routes.ADMIN_PANEL, page: () => AdminPanelScreen()),
  ];
}
