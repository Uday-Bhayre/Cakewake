import 'package:cakewake_vendor/core/services/api_service.dart';
import '../model/login_request.dart';
import '../model/login_response.dart';

class AuthRepository {
  final ApiService _apiService;
  

  AuthRepository(this._apiService);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final endpoint = '/auth/verify-otp';

      final response = await _apiService.post(endpoint, data: request.toJson());
      // print('Login response: ${response.data}');
      return LoginResponse.fromJson(response.data);
    } catch (e) {
      // print('Signup error details: $e');
      throw Exception('Signup failed: $e');
    }
  }





 

  Future<Map<String, dynamic>> sendOtp(String mobileNumber) async {
    try {
      final response = await _apiService.post(
        '/auth/send-otp',
        data: {'mobileNumber': mobileNumber},
      );
      print('Send OTP response: ${response.data}');
      return response.data;
    } catch (e, stack) {
      print('Send OTP error: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  }

  
}
