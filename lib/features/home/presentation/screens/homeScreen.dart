import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/home/presentation/widgets/cartWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
int currentIndexx = 0;
PageController _pageController = PageController();
class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
          
              Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
             
              Text('Hi, welcom back', style: Appfonts.textStylepink.copyWith(fontSize: 18.sp ,fontWeight: FontWeight.w800),),
              Spacer(),
              Icon(Icons.notifications, color: AppColor.primaryColor, size: 30.sp,),
            ],
          ),
              SizedBox(height: 25.h,),
                
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Special offers', style: Appfonts.textStyleblack.copyWith(fontSize: 18.sp),)),
             
             SizedBox(height: 20.h,),
             SizedBox(
              height: 200,
               child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index){
                
                
                return Container(
                  margin: EdgeInsets.all(10.sp),
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: AssetImage('assets/images/fashion shop-rafiki 1.png'),
                      fit: BoxFit.cover
                    )
                  ),
                );
               }, itemCount: 5,),
            
                          
             ),
                  SmoothPageIndicator(  

                            controller: _pageController,  // PageController    
                            count: 5, 
                            effect: WormEffect(
                              type: WormType.underground,
                              radius: 15,
                              dotWidth: 12,
                  dotHeight: 12,
                  
            
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
              SizedBox(height: 20.h,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Categories', style: Appfonts.textStyleblack.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w600),)),
              SizedBox(height: 20.h,),
              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
          
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                            color: currentIndexx == index ? AppColor.primaryColor : AppColor.black.withOpacity(0.5),
                            width: 1.5
                          ),
          
                          backgroundColor: currentIndexx == index ? AppColor.primaryColor : AppColor.isideTextFieldColor,
                          shape: RoundedRectangleBorder(
                            
                            borderRadius: BorderRadius.circular(20.r),
                          )
                        ),
                      onPressed: (){
                        setState(() {
                          currentIndexx = index;
          
                        });
                      },
                      child: Text('data', style: Appfonts.textStylewhite.copyWith(
                        color: currentIndexx == index ? AppColor.white : AppColor.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600
                      ),),
                    ),
                  );
                } 
                
                ),
              ),
           
              
             SizedBox(height: 15.h,),
               Expanded(
                  child: GridView.builder(
                                
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 25,
                    
                    crossAxisCount:2), itemBuilder: (context, index){
                  return Cartwidget();
                                 }, itemCount: 6,
                                 ),
                ),
             
          
            ],
          ),
        ),
      
    );
  }
}