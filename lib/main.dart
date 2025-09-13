import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'controllers/clothes_controller.dart';
import 'routes/app_pages.dart';
import 'localization_service.dart'; // ✅ Import Localization Service
import 'core/responsive_helper.dart'; // ✅ Import Responsive Helper

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure system UI for better iOS experience
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  
  // Initialize Firebase with proper error handling
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
    // Continue without Firebase for now
  }
  
  // Register controller with error handling
  try {
    Get.put(ClothesController());
    print('Controller initialized successfully');
  } catch (e) {
    print('Controller initialization error: $e');
    // Continue without controller to prevent crash
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true, // Better for iOS
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Viton - Virtual Try-On',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            // iOS-specific theme adjustments
            platform: TargetPlatform.iOS,
            cupertinoOverrideTheme: CupertinoThemeData(
              primaryColor: Color(0xFFD19688),
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                textStyle: TextStyle(
                  fontFamily: '.SF Pro Text',
                  fontSize: 17,
                ),
              ),
            ),
            // Enhanced iOS theme
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: '.SF Pro Text',
              ),
            ),
            // Safe area handling
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,

          // ✅ Localization Configuration with error handling
          translations: LocalizationService(),
          locale: Get.deviceLocale ?? Locale('en', 'US'), // Safe fallback
          fallbackLocale: Locale('en', 'US'), // Default language fallback
          
          // ✅ Enhanced iOS-specific configurations with error handling
          builder: (context, widget) {
            try {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(1.0), // Simplified for stability
                  // Ensure proper safe area handling
                  padding: EdgeInsets.zero,
                ),
                child: SafeArea(
                  child: widget ?? Container(
                    color: Colors.white,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        radius: 20,
                        color: Color(0xFFD19688),
                      ),
                    ),
                  ),
                ),
              );
            } catch (e) {
              print('Builder error: $e');
              return Container(
                color: Colors.white,
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(
                          radius: 20,
                          color: Color(0xFFD19688),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontFamily: '.SF Pro Text',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
