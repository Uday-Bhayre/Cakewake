import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart' as custom_theme;
import 'core/services/auth_service.dart';
import 'features/main_navigation_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cake Wake Vendor',
      debugShowCheckedModeBanner: false,
      theme: custom_theme.AppTheme.lightTheme,
      darkTheme: custom_theme.AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      // home: const MainNavigationView(),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
      builder: (context, child) {
        // Handle error widget
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Material(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Something went wrong!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!kReleaseMode) ...[
                    const SizedBox(height: 8),
                    Text(
                      details.exception.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed('/login'),
                    child: const Text('Return to Login'),
                  ),
                ],
              ),
            ),
          );
        };

        // Initialize EasyLoading
        child = EasyLoading.init()(context, child);
        return child;
      },
      defaultTransition: Transition.fadeIn,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: const Duration(milliseconds: 200),
      onInit: () {
        // Check auth status after initialization
        Future.delayed(const Duration(milliseconds: 100), () {
          final isLoggedIn = AuthService.to.isLoggedIn;
          if (isLoggedIn) {
            Get.snackbar(
              'Welcome Back',
              'You are logged in',
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green.withOpacity(0.7),
              colorText: Colors.white,
            );
          }
        });
      },
      // Handle 404 routes
      unknownRoute: GetPage(
        name: '/not-found',
        page: () => Scaffold(
          appBar: AppBar(
            title: const Text('Page Not Found'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60),
                const SizedBox(height: 16),
                const Text('Page not found!'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed('/login'),
                  child: const Text('Return to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
