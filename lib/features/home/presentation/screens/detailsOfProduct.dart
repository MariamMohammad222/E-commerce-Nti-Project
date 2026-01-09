import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';

class Detailsofproduct extends StatelessWidget {
  const Detailsofproduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            height: 350.h,
            width: double.infinity.w,
            fit: BoxFit.fill,
            'assets/images/flower-1379579544f6a.jpg'),
            SizedBox(height: 15,),
            Padding(
              padding:EdgeInsetsGeometry.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Product Name', style: Appfonts.textStyleblack.copyWith(fontSize: 18),),
                      Spacer(),
                      Text('5.5', style: Appfonts.textStyleblack.copyWith(fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(' Description', style: Appfonts.textStyleblack.copyWith(fontSize: 17 ,fontWeight: FontWeight.w500 ),),
                  SizedBox(height: 10,),
                  Text(
                    textAlign:TextAlign.left,
                    'hhdhgggggggggggggggggggggggggggggggcxgxhhhhhhhhhhhhgcggdgcgdcgdgcgdcghdcdcdcdcdcdc',style: Appfonts.textStylegrey.copyWith(fontSize: 15,fontWeight: FontWeight.w500),),
                  SizedBox(height: 150,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('Price',style: Appfonts.textStyleblack.copyWith(fontSize: 17),),
                          Text('\$50',style: Appfonts.textStylepink.copyWith(fontSize: 17),),
                      ]),
                      Spacer(),
                      ElevatedButton(
                        
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(230.w, 50.h),
                            backgroundColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)
                            )
                          ),
                          onPressed: (){}, child: Text('Add to cart',style: Appfonts.textStylewhite.copyWith(fontSize: 14),)),
                      
                    
                  ])
                ],
              ),
            )
        ],
      ),
    );
  }
}