import 'package:cakewake_vendor/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/services/auth_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage first
  await GetStorage.init();

  // Clear any existing instances
  Get.reset();


  // Initialize core services with proper type annotation
  final authService = Get.put<AuthService>(AuthService(), permanent: true);
  final apiService = Get.put<ApiService>(ApiService(), permanent: true);

  // Wait for auth service to initialize
  await authService.init();

  // Configure loading indicators
  configureEasyLoading();

  // Initialize core services
  Get.put(AuthService(), permanent: true);
  Get.put(ApiService(), permanent: true);

  // Run app
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}


void configureEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black.withOpacity(0.5)
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    // Add error and success configurations
    ..errorWidget = Icon(Icons.error, color: Colors.white, size: 45.0)
    ..successWidget = Icon(Icons.check_circle, color: Colors.white, size: 45.0);
}

