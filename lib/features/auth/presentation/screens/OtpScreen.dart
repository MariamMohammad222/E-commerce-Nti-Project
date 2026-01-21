import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/auth/presentation/cubit/AuthCubit.dart';
import 'package:nti_project_final/features/auth/presentation/screens/ResetPasswordScreen.dart';

enum OtpPurpose { verifyEmail, resetPassword }

class OtpScreen extends StatefulWidget {
  final String email;
  final OtpPurpose purpose;

  const OtpScreen({
    super.key,
    required this.email,
    required this.purpose,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int codeLength = 6;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];

  bool isResendEnabled = true;
  int resendSeconds = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < codeLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var ctrl in _controllers) ctrl.dispose();
    for (var node in _focusNodes) node.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String get _otpCode => _controllers.map((c) => c.text).join();

  void _startResendTimer() {
    setState(() {
      isResendEnabled = false;
      resendSeconds = 30;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (resendSeconds > 0) {
          resendSeconds--;
        } else {
          isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    context.read<AuthCubit>().resendOtp(widget.email);
    _startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message ?? "")));
          } else if (state is AuthOtpVerified) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ResetPasswordScreen(
                  email: widget.email,
                  token: state.token,
                ),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.22),
                  Text("Enter Verification Code",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 10),
                  Text("We have sent a code to your email",
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(widget.email,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black)),
                  const SizedBox(height: 40),
                  // OTP Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(codeLength, (index) {
                      return SizedBox(
                        width: 45,
                        height: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 18),
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? Colors.white : Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: isDark ? Colors.white : Colors.grey),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < codeLength - 1) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_otpCode.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter full code")));
                          return;
                        }

                        if (widget.purpose == OtpPurpose.verifyEmail) {
                          context.read<AuthCubit>().verifyEmailOtp(
                              email: widget.email, otp: _otpCode);
                        } else {
                          context.read<AuthCubit>().verifyResetToken(
                               widget.email,  _otpCode);
                        }
                      },
                      child: state is AuthLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Verify",
                              style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: isResendEnabled ? _resendOtp : null,
                    child: Text(
                      isResendEnabled
                          ? "Resend Code"
                          : "Resend in $resendSeconds s",
                      style: const TextStyle(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
