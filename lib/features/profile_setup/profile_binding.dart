import 'package:get/get.dart';
import 'controller/profile_setup_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileSetupController>(ProfileSetupController(), permanent: true);
    // Add other controllers/services for profile setup here if needed
  }
}
