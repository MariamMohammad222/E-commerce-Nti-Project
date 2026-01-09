import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/features/home/presentation/screens/detailsOfProduct.dart';

class Cartwidget extends StatelessWidget {
  const Cartwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Detailsofproduct()));
      },
      child: Container(
        height: 200.h,
        
        
        child: Column(
          children: [
            Image.asset(
      
              fit: BoxFit.cover,
              width: double.infinity.w,
      
              height: 100.h,
              'assets/images/flower-1379579544f6a.jpg'),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Product Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                  Icon(Icons.star, color: Colors.amber, size: 16,),
                  Text('\$50', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}