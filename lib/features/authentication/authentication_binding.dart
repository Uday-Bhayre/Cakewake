import 'package:cakewake_vendor/core/services/api_service.dart';
import 'package:cakewake_vendor/core/services/auth_service.dart';
import 'package:cakewake_vendor/features/authentication/controller/login_controller.dart';
import 'package:cakewake_vendor/features/authentication/repository/auth_repository.dart';
import 'package:get/get.dart';


class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    // Verify core services are available
    assert(Get.isRegistered<AuthService>(), 'AuthService must be initialized');
    assert(Get.isRegistered<ApiService>(), 'ApiService must be initialized');

    // Repositories
    Get.lazyPut<AuthRepository>(
      () => AuthRepository(Get.find<ApiService>()),
      fenix: true,
    );

  

    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<AuthRepository>()),
      fenix: true,
    );
  }
}
