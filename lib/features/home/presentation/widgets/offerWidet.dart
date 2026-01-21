import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Offerwidet extends StatelessWidget {
   Offerwidet({super.key, required this.text1, required this.text2, required this.imagepath});
  String text1;
  String text2;
  String imagepath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  DecorationImage(
              image: Image.network(imagepath).image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}