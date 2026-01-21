import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/home/presentation/widgets/cartWidget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/features/Cart/data/dataSource/CartCubit.dart';
import 'package:nti_project_final/features/Cart/presentation/screens/models/CartModel.dart';

class Detailsofproduct extends StatelessWidget {
   Detailsofproduct({Key? key, required this.id, required this.image, required this.name, required this.description, required this.price, required this.rate}) : super(key: key);
   final String id;
   String image;
   String name;
   String description;
   double rate;
   double price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
         SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
             productImage(image,height: 400),
                SizedBox(height: 15.h,),
                Padding(
                  padding:EdgeInsetsGeometry.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name, style: Appfonts.textStyleblack.copyWith(fontSize: 18),),
                          Spacer(),
                          Text(rate.toString(), style: Appfonts.textStyleblack.copyWith(fontSize: 18),)
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Text('Description', style: Appfonts.textStyleblack.copyWith(fontSize: 17 ,fontWeight: FontWeight.w500 ),),
                      SizedBox(height: 10,),
                      Text(
                        textAlign:TextAlign.left,
                          description,style: Appfonts.textStylegrey.copyWith(fontSize: 15,fontWeight: FontWeight.w500),),
                      SizedBox(height: 60.h,),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('Price',style: Appfonts.textStyleblack.copyWith(fontSize: 17),),
                              Text(price.toString(),style: Appfonts.textStylepink.copyWith(fontSize: 17),),
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
onPressed: () {
  context.read<CartCubit>().addItem(id);

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Added to cart'),
      duration: Duration(seconds: 1),
    ),
  );
},
                              child:Text('Add to cart',style: Appfonts.textStylewhite.copyWith(fontSize: 14),)),
                          
                        
                      ]),
                      SizedBox(height: 50.h,),
                    ],
                  ),
                )
            ],
                   
                 ),
         ),
    );
  }
}