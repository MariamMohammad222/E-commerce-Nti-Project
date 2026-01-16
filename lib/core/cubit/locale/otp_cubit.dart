import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/features/auth/data/domain/presentation/auth_remote_data_source.dart';

abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSuccess extends OtpState {}

class OtpError extends OtpState {
  final String message;
  OtpError(this.message);
}

class OtpCubit extends Cubit<OtpState> {
  final AuthRemoteDataSource auth;

  OtpCubit(this.auth) : super(OtpInitial());

  Future<void> verifyOtp(String email, String otp) async {
    emit(OtpLoading());
    try {
      await auth.verifyOtp(email, otp);
      emit(OtpSuccess());
    } catch (e) {
      emit(OtpError("Invalid OTP"));
    }
  }
}
