import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/auth/presentation/cubit/AuthCubit.dart';
import 'package:nti_project_final/features/auth/presentation/screens/LoginScreen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String token;
  const ResetPasswordScreen({super.key, required this.email, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Password", style: TextStyle(fontSize: 18.sp, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
           if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message ?? "Password Reset Successful")));
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
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
                    Text("Create New Password", style: TextStyle(
                      fontSize: 22.sp, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    )),
                    SizedBox(height: 10.h),
                    Text("Your new password must be different from previous used passwords", style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey
                    )),
                     SizedBox(height: 40.h),
                    
                    Text("Password", style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    )),
                    SizedBox(height: 10.h),
                    _buildTextField(passwordController, "****************", isPassword: true),
                     SizedBox(height: 20.h),
                    Text("Confirm Password", style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black
                    )),
                    SizedBox(height: 10.h),
                    _buildTextField(confirmPasswordController, "****************", isPassword: true),
                  
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
                             if (passwordController.text != confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Passwords do not match")));
                                return;
                             }
                             context.read<AuthCubit>().resetPasswordNew(
                               widget.email, 
                               passwordController.text,
                               widget.token
                             );
                           }
                        }, 
                        child: state is AuthLoading 
                          ? CircularProgressIndicator(color: Colors.white,) 
                          : Text("Reset Password", style: TextStyle(fontSize: 16.sp, color: Colors.white),)
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

  Widget _buildTextField(TextEditingController controller, String hint, {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(
         color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Required";
        return null; 
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.grey)
        ),
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10.r),
           borderSide: BorderSide(color: Colors.grey.shade300)
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : AppColor.isideTextFieldColor
      ),
    );
  }
}
