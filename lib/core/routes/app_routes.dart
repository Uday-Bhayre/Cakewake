import 'package:cakewake_vendor/core/services/auth_service.dart';
import 'package:cakewake_vendor/features/authentication/view/otp_view.dart';
import 'package:cakewake_vendor/features/main_navigation_view.dart';
import 'package:cakewake_vendor/features/onboarding/view/onboarding_screen.dart';
import 'package:cakewake_vendor/features/profile/view/profile_view.dart';
import 'package:cakewake_vendor/features/profile_setup/profile_setup_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/business_details%20setup/business_info_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/business_details%20setup/contract_upload_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/business_details%20setup/fssai_upload_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/delivery_setup/location_auto_detected_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/business_details%20setup/name_email_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/payment_setup/payment_details_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/delivery_setup/select_area_view.dart';
import 'package:cakewake_vendor/features/profile_setup/view/delivery_setup/select_city_view.dart';
import 'package:cakewake_vendor/features/splash_screen/view/splash_screen.dart';
import 'package:get/get.dart';
import '../../features/authentication/view/mobile_auth.dart';
import '../../features/authentication/authentication_binding.dart';
import 'package:cakewake_vendor/features/home/view/home_view.dart';
import 'package:cakewake_vendor/features/home/home_binding.dart';
import 'package:cakewake_vendor/features/orders/view/orders_view.dart';
import 'package:cakewake_vendor/features/orders/orders_binding.dart';
import 'package:cakewake_vendor/features/earnings/view/earning_view.dart';
import 'package:cakewake_vendor/features/earnings/earnings_binding.dart';
import 'package:cakewake_vendor/features/profile_setup/profile_binding.dart';

class AppRoutes {
  static String get initial {
    final authService = Get.put(AuthService());
    if (authService.hasValidToken()) {
      if(authService.hasProfile == true) {
        return '/navigation';
      }
      return '/profile/setup';
    } else {
      return '/login';
    }
  }

  static final routes = [
    // Auth routes (public)
    GetPage(name: '/splash', page: () => SplashScreen()),
    GetPage(name: '/onboarding', page: () => OnBoardingScreen()),
    GetPage(
      name: '/login',
      page: () => const MobileAuth(),
      binding: AuthenticationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/otp',
      page: () => OtpView(),
      binding: AuthenticationBinding(),
      transition: Transition.fadeIn,
    ),
    // Profile routes
    GetPage(
      name: '/profile/contract_upload',
      page: () => ContractUploadView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/fssai_upload',
      page: () => FssaiUploadView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/setup',
      page: () => ProfileSetupView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/name_email',
      page: () => NameEmailView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/business_info',
      page: () => BusinessInfoView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/location_auto_detected',
      page: () => LocationAutoDetectedView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/select_city',
      page: () => SelectCityView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/select_area',
      page: () => SelectAreaView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/profile/payment_details',
      page: () => PaymentDetailsView(),
      binding: ProfileBinding(),
    ),
    // Main navigation routes
    GetPage(
      name: '/home',
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/orders',
      page: () => const OrdersView(),
      binding: OrdersBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/earnings',
      page: () => const EarningView(),
      binding: EarningsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileView(),
      // binding: ProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: '/navigation',
      page: () => const MainNavigationView(),
      transition: Transition.fadeIn,
    ),
  ];

  // Navigation helper methods
  static void goToLogin() => Get.offAllNamed('/login');
  // static void goToProfile() => Get.offAllNamed('/profile');
}
