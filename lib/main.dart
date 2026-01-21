import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/network/dio_consumer.dart';
import 'package:nti_project_final/core/theme/appThemeCubit.dart';
import 'package:nti_project_final/core/theme/appThemeData.dart';
import 'package:nti_project_final/features/Cart/data/dataSource/CartCubit.dart';
import 'package:nti_project_final/features/auth/presentation/cubit/AuthCubit.dart';
import 'package:nti_project_final/features/auth/presentation/screens/LoginScreen.dart';
import 'package:nti_project_final/features/home/presentation/screens/bottomNvigationbar.dart';
import 'package:nti_project_final/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:nti_project_final/core/utils/app_shared_preferences.dart';
import 'package:nti_project_final/features/splash/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioConsumer().init();
  final String? token = await AppSharedPreferences.getToken();
  final bool onboardingVisited = await AppSharedPreferences.getOnboarding();
  print(token);
  Widget startScreen;
  if (!onboardingVisited) {
    startScreen = SplashScreen(nextScreen: OnboardingScreen(),);
  } else if (token != null && token.isNotEmpty) {
    startScreen = HomwScreen();
  } else {
    startScreen = LoginScreen();
  }

   runApp(
    MultiBlocProvider(
      providers: [
         BlocProvider(create: (_) => AppThemeCubit()),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
         BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),

      ],
      child: MyApp(startScreen: startScreen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  const MyApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // مهم
      minTextAdapt: true,
      splitScreenMode: true,
      
      builder: (context, child) {
        return BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeMode,
              theme: AppThemeData.lightTheme,
              darkTheme: AppThemeData.darkTheme,
              home: LoginScreen(), // SplashScreen(), 
            );
          },
        );
      },
    );
  }
}
