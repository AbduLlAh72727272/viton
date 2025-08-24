import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controllers/clothes_controller.dart';
import 'routes/app_pages.dart';
import 'localization_service.dart'; // ✅ Import Localization Service

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ClothesController()); // ✅ Register Controller

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Virtual Try-On',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,

          // ✅ Localization Configuration
          translations: LocalizationService(),
          locale: Get.deviceLocale, // Load device language at startup
          fallbackLocale: Locale('en', 'US'), // Default language fallback
        );
      },
    );
  }
}
