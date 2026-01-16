import 'package:flutter/material.dart';
import 'package:nti_project_final/features/auth/presentation/screens/otp_screen.dart';
import 'package:nti_project_final/features/auth/presentation/screens/otp_success_screen.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';


class AppRouter {
 Route? generateRoute(RouteSettings settings) {
   switch (settings.name) {
     case Routes.splashScreen:
       return _createRoute(const SplashScreen());
     case Routes.onBoardingScreen:
       return _createRoute(const OnboardingScreen());
     case Routes.otpScreen:
       return _createRoute( OtpScreen());
     case Routes.otpSuccess:
       return _createRoute(const OtpSuccessScreen());



     default:
       return null;
   }
 }


 PageRouteBuilder _createRoute(Widget page) {
   return PageRouteBuilder(
     transitionDuration: const Duration(milliseconds: 400),
     pageBuilder: (context, animation, secondaryAnimation) => page,
     transitionsBuilder: (context, animation, secondaryAnimation, child) {
       return FadeTransition(
         opacity: animation,
         child: child,
       );
     },
   );
 }
}
