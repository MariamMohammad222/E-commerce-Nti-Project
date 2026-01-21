import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/features/auth/data/AuthRepo.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthOtpVerified extends AuthState {
  final String message;
  final String token;
  AuthOtpVerified({required this.message, required this.token});
}

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _repo = AuthRepo();

  AuthCubit() : super(AuthInitial());

Future<void> register({
  required String firstName,
  required String lastName,
  required String email,
  required String password,
}) async {
  emit(AuthLoading());
  try {
    final msg = await _repo.register(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    emit(AuthSuccess(msg));
  } catch (e) {
    // هنا e هتكون رسالة السيرفر الفعلية زي: "Email is already in use."
    emit(AuthError(e.toString()));
  }
}

Future<void> resendOtp(String email) async {
  emit(AuthLoading());
  try {
    final msg = await _repo.forgotPassword(email); // أو أي API لإرسال OTP تاني
    emit(AuthSuccess(msg)); // هيرجع الرسالة من السيرفر مباشرة
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}

Future<void> verifyEmailOtp({required String email, required String otp}) async {
  emit(AuthLoading());
  try {
    final msg = await _repo.verifyEmail(email, otp);
    emit(AuthSuccess(msg));
  } catch (e) {
    // هنا e هتكون رسالة السيرفر الفعلية زي: "Email is not valid." أو "Otp must be 6 characters long."
    emit(AuthError(e.toString()));
  }
}

  Future<void> validateOtp(String email, String otp) async {
    emit(AuthLoading());
    try {
      final msg = await _repo.validateOtp(email, otp);
      emit(AuthSuccess(msg));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final msg = await _repo.login(email: email, password: password);
      emit(AuthSuccess(msg));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      final msg = await _repo.forgotPassword(email);
      emit(AuthSuccess(msg));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(
      String email, String otp, String newPassword) async {
    emit(AuthLoading());
    try {
      final msg = await _repo.resetPassword(email, otp, newPassword);
      emit(AuthSuccess(msg));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  Future<void> verifyResetToken(String email, String otp) async {
    emit(AuthLoading());
    try {
      final result = await _repo.verifyResetToken(email, otp);
      emit(AuthOtpVerified(
        token: result['token'],
        message: result['message']
      ));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPasswordNew(String email, String newPassword, String token) async {
    emit(AuthLoading());
    try {
      final msg = await _repo.resetPasswordWithToken(
        email: email, 
        newPassword: newPassword, 
        token: token
      );
      emit(AuthSuccess(msg));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}

