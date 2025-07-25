import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../features/authentication/model/user.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  // Storage keys
  static const String _tokenKey = 'token';
  static const String _userKey = 'user';
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _hasProfileKey = 'hasProfile';

  // Observables
  final _isLoggedIn = false.obs;
  final _user = Rx<User?>(null);
  final _token = RxnString();
  final _hasProfile = RxnBool();
  final _box = GetStorage();

  // Getters
  bool get isLoggedIn => _isLoggedIn.value;
  User? get currentUser => _user.value;
  String? get token => _token.value;
  bool? get hasProfile => _hasProfile.value;

  Future<AuthService> init() async {
    try {
      await GetStorage.init();
      checkLoginStatus();
      return this;
    } catch (e) {
      print('AuthService init error: $e');
      return this;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    try {
      final token = _box.read<String>(_tokenKey);
      final userData = _box.read(_userKey);

      if (token != null && userData != null && _isTokenValid(token)) {
        _token.value = token;
        _user.value = User.fromJson(userData);
        _isLoggedIn.value = true;
        _hasProfile.value = _box.read<bool>(_hasProfileKey);
      } else {
        _clearSession();
      }
    } catch (e) {
      _clearSession();
      _showError('Session validation failed');
    }
  }

  Future<void> saveUserSession(String token, bool? hasProfile, User user) async {
    try {
      if (!_isTokenValid(token)) {
        throw Exception('Invalid token');
      }

      await Future.wait([
        _box.write(_tokenKey, token),
        _box.write(_isLoggedInKey, true),
        _box.write(_userKey, user.toJson()),
        _box.write(_hasProfileKey, hasProfile),
      ]);

      _token.value = token;
      _user.value = user;
      _isLoggedIn.value = true;
      _hasProfile.value = hasProfile;
    } catch (e) {
      _showError('Failed to save session');
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await Future.wait([
        _box.remove(_tokenKey),
        _box.remove(_isLoggedInKey),
        _box.remove(_userKey),
        _box.remove(_hasProfileKey),
      ]);

      _clearSession();
      Get.offAllNamed('/login');
    } catch (e) {
      _showError('Logout failed');
      rethrow;
    }
  }

  void _clearSession() {
    _token.value = null;
    _user.value = null;
    _isLoggedIn.value = false;
    _hasProfile.value = null;
  }

  Future<void> updateUser(User user, bool? hasProfile) async {
    try {
      if (!hasValidToken()) {
        throw Exception('No valid token found');
      }

      await _box.write(_userKey, user.toJson());
      _user.value = user;
      _hasProfile.value = hasProfile;
    } catch (e) {
      _showError('Failed to update user data');
      rethrow;
    }
  }

  bool hasValidToken() {
    final token = _token.value;
    return token != null && _isTokenValid(token);
  }

  bool _isTokenValid(String token) {
    try {
      if (token.isEmpty) return false;

      // Decode and validate JWT token
      // print(token);
      final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

      // Check if token has expired
      if (JwtDecoder.isExpired(token)) {
        _showError('Session has expired. Please login again.');
        return false;
      }

      // Validate required claims
      if ( 
          !decodedToken.containsKey('id') ||
          !decodedToken.containsKey('role')) {
        return false;
      }

      // Get expiration time
      final expirationDate = JwtDecoder.getExpirationDate(token);
      final now = DateTime.now();

      // Check if token is about to expire (e.g., within 5 minutes)
      if (expirationDate.difference(now).inMinutes <= 5) {
        // You could trigger token refresh here
        _showError('Session is about to expire');
      }

      return true;
    } catch (e) {
      print('Token validation error: $e');
      return false;
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
    );
  }
}
