import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/features/onboarding/presentation/screens/models/onboardingModel.dart';

class Onboardingwidget extends StatelessWidget {
   Onboardingwidget({super.key, required this.onboardingmodel});
   Onboardingmodel onboardingmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
          
              child: SizedBox(
                width: double.infinity,
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                
                  
                  children: [
                    SizedBox(height: 20.h),
                   
                     
                         
                          
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                             
                              'Skip', style: Appfonts.textStyleblack.copyWith( fontSize: 18.sp),),
                          ),
                       
                      
                    
                    Spacer(),
                    Image.asset(
                      
                      width: 300.w,
                      height: 300.h,
                
                      onboardingmodel.image),
                      SizedBox(height: 20.h),
                     Text(onboardingmodel.title, style: Appfonts.textStyleblack ),
                      SizedBox(height: 10.h),
                      Text(onboardingmodel.body, style: Appfonts.textStylegrey, textAlign: TextAlign.center,),
                      Spacer(),
                  ],
                ),
              ),
            ),
        
        
      );
  }
}