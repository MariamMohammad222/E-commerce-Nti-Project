import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/auth/presentation/cubit/AuthCubit.dart';
import 'package:nti_project_final/features/auth/presentation/screens/OtpScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password", style: TextStyle(fontSize: 18.sp, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
           if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? "Code sent")));
             Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(email: emailController.text, purpose: OtpPurpose.resetPassword,)));
          } else if (state is AuthError) {
             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text("Reset Password", style: TextStyle(
                      fontSize: 24.sp, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    )),
                    SizedBox(height: 10.h),
                    Text("Enter your email and we'll send you instructions to reset your password", style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey
                    )),
                     SizedBox(height: 40.h),
                    
                    Text("Email", style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    )),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: emailController,
                      style: TextStyle(
                         color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                      ),
                      validator: (value) {
                         if (value == null || value.isEmpty) return "Required";
                         return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                        filled: true,
                        fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : AppColor.isideTextFieldColor
                      ),
                    ),
                  
                    SizedBox(height: 40.h),
              
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor, 
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))
                        ),
                        onPressed: state is AuthLoading ? null : () {
                           if (_formKey.currentState!.validate()) {
                             context.read<AuthCubit>().forgotPassword(emailController.text);
                           }
                        }, 
                        child: state is AuthLoading 
                          ? CircularProgressIndicator(color: Colors.white,) 
                          : Text("Send Instructions", style: TextStyle(fontSize: 16.sp, color: Colors.white),)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
