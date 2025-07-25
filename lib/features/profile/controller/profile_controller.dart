import 'package:get/get.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController {
  Rx<ProfileModel> profile = ProfileModel(
    name: 'John Doe',
    email: 'john.doe@email.com',
    phone: '+91 9876543210',
    businessName: 'CakeWake Vendor',
    businessAddress: '123, Main Street, Delhi',
    profileImageUrl: '',
  ).obs;
}
