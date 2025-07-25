import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    final box = GetStorage();
    final isCompleted = box.read('onboardingCompleted') ?? false;

     await Future.delayed(const Duration(seconds: 3),(){
       if (isCompleted) {
      Get.offNamed('/home');
    } else {
      Get.offNamed('/onboarding');
    }
     });
  }
}