import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/features/home/presentation/screens/homeScreen.dart';
import 'package:nti_project_final/features/onboarding/presentation/screens/onboarding_screen.dart';


void main() async {
 
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
         
          home: Homescreen(),
        );
      },
    
    );

  }
}