import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/favorites/presentation/screens/favorits.dart';
import 'package:nti_project_final/features/home/presentation/screens/detailsOfProduct.dart';
import 'dart:convert';

import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';
class Cartwidget extends StatefulWidget {
  final Modelofproducts product;
   Cartwidget({super.key, required this.product});

  @override
  State<Cartwidget> createState() => _CartwidgetState();
}

class _CartwidgetState extends State<Cartwidget> {
  @override
  Widget build(BuildContext context) {
    final isFav =
        FavoritesManager.isFavorite(widget.product.id);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Detailsofproduct(
              id: widget.product.id,
              image: widget.product.image,
              name: widget.product.name,
              description: widget.product.description,
              price: widget.product.price,
              rate: widget.product.rate,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              productImage(widget.product.image, height: 150),

              /// ❤️ القلب
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      FavoritesManager.toggleFavorite(widget.product);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
                  
                  SizedBox(height: 10,),
                  Padding(
                    padding:EdgeInsetsDirectional.only(start: 5.0.w) ,
                    child: Text(
  widget.product.name,
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
,
                  ),
                  SizedBox(height: 5,),
                     Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.product.price.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            
                            Container(
                             
                              width: 30.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.primaryColor
                
                              ),
                              child: 
                                IconButton(
                                   padding: EdgeInsets.zero,
                                    constraints: BoxConstraints(),
                                  
                                  icon: Align(
                                    alignment: AlignmentGeometry.center,
                                    child: Icon( Icons.add, color: Colors.white,)),
                                  onPressed: (){},
                                  
                                
                              ),
                            ),
                          ],
                        ),
                    

        ],
      ),
    );
        
  }
}
Widget productImage(String image  ,{required int height}) {
  return Stack(
    children: [
      // الصورة سواء Base64 أو URL
      if (image.startsWith('data:image'))
        Image.memory(
          base64Decode(image.split(',').last),
          height:height.h,
          width: double.infinity,
          fit: BoxFit.fill,
        )
      else
        Image.network(
          image,
          height: height.h,
          width: double.infinity,
          fit: BoxFit.fill,
          errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
        ),

      // القلب فوق الصورة
     
    ],
  );
}


class FavoritesManager {
  static final ValueNotifier<List<Modelofproducts>> favoritesNotifier =
      ValueNotifier([]);

  static List<Modelofproducts> get favorites => favoritesNotifier.value;

  static bool isFavorite(String id) {
    return favorites.any((p) => p.id == id);
  }

  static void toggleFavorite(Modelofproducts product) {
    final current = List<Modelofproducts>.from(favoritesNotifier.value);
    if (isFavorite(product.id)) {
      current.removeWhere((p) => p.id == product.id);
    } else {
      current.add(product);
    }
    favoritesNotifier.value = current;
  }
}
