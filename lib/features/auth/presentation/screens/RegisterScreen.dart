import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/auth/presentation/cubit/AuthCubit.dart';
import 'package:nti_project_final/features/auth/presentation/screens/LoginScreen.dart';
import 'package:nti_project_final/features/auth/presentation/screens/OtpScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? (isDark ? Colors.white : Colors.black);
    final hintColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    final borderColor = Theme.of(context).dividerColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "OTP sent to your email")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => OtpScreen(
                  email: emailController.text,
                  purpose: OtpPurpose.verifyEmail,
                ),
              ),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    // Avatar placeholder
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person, size: 50.sp, color: Theme.of(context).iconTheme.color),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Create an account",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                    ),
                    SizedBox(height: 30.h),

                    _buildTextField(firstnameController, "First Name", textColor, hintColor, borderColor),
                    SizedBox(height: 15.h),
                    _buildTextField(lastnameController, "Last Name", textColor, hintColor, borderColor),
                    SizedBox(height: 15.h),
                    _buildTextField(emailController, "Email", textColor, hintColor, borderColor),
                    SizedBox(height: 15.h),
                    _buildTextField(passwordController, "Password", textColor, hintColor, borderColor, isPassword: true),
                    SizedBox(height: 25.h),

                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                        ),
                        onPressed: state is AuthLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().register(
                                        firstName: firstnameController.text,
                                        lastName: lastnameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                }
                              },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Sign Up",
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                              ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? ", style: TextStyle(color: hintColor)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: AppColor.primaryColor, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    Color textColor,
    Color hintColor,
    Color borderColor, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? !isPasswordVisible : false,
      validator: (value) => value == null || value.isEmpty ? "Required" : null,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: borderColor)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: BorderSide(color: borderColor)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: hintColor),
                onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
              )
            : null,
      ),
    );
  }
}
