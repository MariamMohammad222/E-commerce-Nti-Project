import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/home/presentation/screens/bottomNvigationbar.dart';
import 'package:nti_project_final/features/home/presentation/screens/homeScreen.dart';
import 'package:nti_project_final/features/onboarding/presentation/screens/models/onboardingModel.dart';
import 'package:nti_project_final/features/onboarding/presentation/widgets/onboardingWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:nti_project_final/core/utils/app_shared_preferences.dart';
import 'package:nti_project_final/features/auth/presentation/screens/LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
   OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List onboardingPages = [
    Onboardingmodel(
      image: 'assets/images/fashion shop-rafiki 1.png',
      title: 'Choose Products',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    Onboardingmodel(
      image: 'assets/images/Sales consulting-pana1.png',
      title: 'Make Payment',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    Onboardingmodel(
      image: 'assets/images/Shopping bag-rafiki1.png',
      title: 'Get Your Order',
      body: 'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

final PageController _pageController = PageController();
  int currentPage = 0;
 void _nextPage() {
    if (currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      AppSharedPreferences.saveOnboarding(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  void _prevPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                  onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
                        },
              itemBuilder:(context, index) {
              return Onboardingwidget(onboardingmodel: onboardingPages[index],);
                        },),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               TextButton(onPressed: (){
                _prevPage();
               }, child: Text('prev', style: Appfonts.textStylegrey.copyWith(fontSize: 18,fontWeight: FontWeight.w600),)),
                SmoothPageIndicator(    
                          controller: _pageController,  // PageController    
                          count: onboardingPages.length, 
                          effect: WormEffect(
                dotHeight: 10,
                activeDotColor: AppColor.primaryColor,
                          ),  // your preferred effect    
                          onDotClicked: (index) {    
                _pageController.animateToPage(
                        index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                );
                          },
                        ),
                TextButton(onPressed: (){
                    _nextPage();
                  }, child: Text(currentPage == onboardingPages.length -1 ? 'Get Started' : 'Next', style: Appfonts.textStylepink.copyWith(fontSize: 18),)),
                
                    

            


          
              ]
        ),
        SizedBox(height: 40.h,),
          ]
      )
      
      
    
         

    );
  }
}
