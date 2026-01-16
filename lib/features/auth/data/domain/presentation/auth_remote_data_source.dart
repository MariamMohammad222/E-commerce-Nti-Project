import 'package:nti_project_final/core/network/api_consumer.dart';


class AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSource(this.api);

  Future<void> register(String email, String password) async {
    await api.post(
      '/auth/register',
      body: {
        "email": email,
        "password": password,
      },
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    await api.post(
      '/auth/verify-otp',
      body: {
        "email": email,
        "otp": otp,
      },
    );
  }
}
