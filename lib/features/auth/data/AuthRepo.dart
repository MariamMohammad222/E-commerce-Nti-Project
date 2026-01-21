import 'package:nti_project_final/core/network/ApiService.dart';
import 'package:nti_project_final/core/network/Api_Error.dart';
import 'package:nti_project_final/core/network/dio_consumer.dart';
import 'package:nti_project_final/core/utils/app_shared_preferences.dart';
import 'package:dio/dio.dart';
class AuthRepo {
  // دالة لتجيب الـ ApiService بعد init DioConsumer
  Future<ApiService> _api() async {
    await DioConsumer().init();
    return ApiService();
  }

  // ================= REGISTER =================
  Future<String> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      final api = await _api();

      final response = await api.postRequest(
        '/auth/register',
        {
          "email": email,
          "password": password,
          "firstName": firstName,
          "lastName": lastName,
        },
      );

      if (response is Map && response['errors'] != null && response['errors'] is Map) {
        final errors = response['errors'] as Map<String, dynamic>;
        if (errors.isNotEmpty) {
          return errors.values.first[0].toString();
        }
      } else if (response is List && response.isNotEmpty) {
          return response.first.toString();
      }

      return response['message'] ?? "OTP sent to your email";
    } on ApiError catch (e) {
      throw e.message ?? "Registration failed";
    }
  }

  // ================= RESEND OTP =================
  Future<String> resendOtp(String email) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/resend-otp',
      {"email": email},
    );

    if (response is Map && response['errors'] != null && response['errors'] is Map) {
      final errors = response['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) return firstError.first.toString();
        if (firstError is String) return firstError;
      }
    } else if (response is List && response.isNotEmpty) {
        return response.first.toString();
    }

    return response['message'] ?? "OTP resent successfully";
  }

  // ================= VERIFY EMAIL =================
  Future<String> verifyEmail(String email, String otp) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/verify-email',
      {"email": email, "otp": otp},
    );

    if (response is! Map) return response.toString();

    if (response['errors'] != null && response['errors'] is Map) {
      final errors = response['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) return firstError.first.toString();
        if (firstError is String) return firstError;
      }
    }

    return response['message'] ?? "Email verified successfully";
  }

  // ================= VALIDATE OTP =================
  Future<String> validateOtp(String email, String otp) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/validate-otp',
      {"email": email, "otp": otp},
    );

    if (response is Map && response['errors'] != null && response['errors'] is Map) {
      final errors = response['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) return firstError.first.toString();
        if (firstError is String) return firstError;
      }
    } else if (response is List && response.isNotEmpty) {
        return response.first.toString();
    }

    return response['message'] ?? "OTP validated successfully";
  }

  // ================= LOGIN =================
  Future<String> login({
    required String email,
    required String password,
  }) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/login',
      {"email": email, "password": password},
    );

    // ✅ مهم جدًا: التأكد من وجود التوكن
    final token = response['accessToken'];
    if (token == null || token.toString().isEmpty) {
      throw "Invalid login response (token missing)";
    }

    // ✅ حفظ التوكن في SharedPreferences
    await AppSharedPreferences.setData(token);

    return "Login successful";
  }

  // ================= FORGOT PASSWORD =================
  Future<String> forgotPassword(String email) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/forgot-password',
      {"email": email},
    );

    // Defensive check before accessing keys
    if (response is! Map) {
       if (response is List && response.isNotEmpty) return response.first.toString();
       return "Unexpected response format: $response";
    }

    if (response['errors'] != null && response['errors'] is Map) {
      final errors = response['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
        if (firstError is List && firstError.isNotEmpty) return firstError.first.toString();
        if (firstError is String) return firstError;
      }
    }

    return response['message'] ?? "OTP sent to email";
  }

  // ================= RESET PASSWORD =================
  Future<String> resetPassword(String email, String otp, String newPassword) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/reset-password',
      {"email": email, "otp": otp, "newPassword": newPassword},
    );

    return response['message'] ?? "Password reset successfully";
  }

  // ================= VERIFY RESET TOKEN =================
  Future<Map<String, dynamic>> verifyResetToken(String email, String otp) async {
    final api = await _api();

    final response = await api.postRequest(
      '/auth/verify-reset-token',
      {"email": email, "otp": otp},
    );

     if (response is Map && response['errors'] != null && response['errors'] is Map) {
      final errors = response['errors'] as Map<String, dynamic>;
      if (errors.isNotEmpty) {
        final firstError = errors.values.first;
         if (firstError is List && firstError.isNotEmpty) throw firstError.first.toString();
        if (firstError is String) throw firstError;
      }
    } else if (response is List && response.isNotEmpty) {
        throw response.first.toString();
    }

    final token = response['token']; // Assuming the API returns 'token'
    final message = response['message'] ?? "Verified successfully";
    
    // If token is inside a data object or somewhere else, adjust here. 
    // Based on user request: "Response: Success → return temporary reset token"
    
    if (token == null) {
      throw "Token not found in response";
    }

    return {
      "token": token,
      "message": message
    };
  }

  // ================= RESET PASSWORD WITH TOKEN =================
  Future<String> resetPasswordWithToken({
    required String email, 
    required String newPassword, 
    required String token
  }) async {
    // Handle specific request with custom Authorization header
    // We use a fresh Dio instance to avoid the global interceptor overwriting the Authorization header if a stale token exists
    final dio = Dio(BaseOptions(
      baseUrl: "https://accessories-eshop.runasp.net/api",
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      }
    ));

    try {
      final response = await dio.post(
        '/auth/reset-password',
        data: {"email": email, "newPassword": newPassword},
      );
      
      return response.data['message'] ?? "Password reset successfully";
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null && e.response?.data is Map) {
         final errors = e.response?.data['errors'];
         if (errors != null && errors is Map && errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) throw firstError.first.toString();
            if (firstError is String) throw firstError;
         }
         if (e.response?.data['message'] != null) {
           throw e.response?.data['message'];
         }
      }
      throw e.message ?? "Reset password failed";
    }
  }
}

