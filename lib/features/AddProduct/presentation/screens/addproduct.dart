import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const Color primaryColor = Color(0xFFE20075);
  void clear(){
    _nameController.clear();
    _nameArabicController.clear();
    _priceController.clear();
    _stockController.clear();
    _descController.clear();
    _descArabicController.clear();
    _colorController.clear();
    _imagecontroller.clear();

  }
  final _nameController = TextEditingController();
  final _nameArabicController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _descController = TextEditingController();
  final _descArabicController = TextEditingController();
  final _colorController = TextEditingController();
  final _imagecontroller = TextEditingController();

  String selectedCategory = 'Clothing';
  final List<String> categories = ['Clothing', 'Shoes', 'Accessories'];


final Dio dio=Dio();
  Future<void> addProducts() async {
    try {
      final response = await dio.post(
        "https://accessories-eshop.runasp.net/api/products",
        data: {
          "sellerId": "d051dbf3-f5d8-410d-0e50-08de06562562",
          "name": _nameController.text,
          "description": _descController.text,
          "nameArabic": _nameArabicController.text,
          "descriptionArabic": _descArabicController.text,
          "coverPictureUrl":_imagecontroller.text,
          "price": _priceController.text,
          "stock": _stockController.text,
          "color": _colorController.text
        },
      );print("SUCCESS ");
      print(response.data);
    } on DioException catch (e) {
      String errorMessage = e.response?.data.toString() ?? e.message.toString();

      log("Error: $errorMessage");
    } catch (e) {
      log("Error2: $e");
    }
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   Future<void> addProductt() async {
    if (formKey.currentState!.validate()) {
         addProducts();
         SnackBar(
  backgroundColor: AppColor.primaryColor,
  content: const Text(
    'Product added successfully',
    style: TextStyle(color: Colors.white),
  ),
  behavior: SnackBarBehavior.floating,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  margin: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
)
;
         clear();

     
      
    }
   
       


    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(centerTitle: true,
        leading: BackButton(color: Theme.of(context).iconTheme.color),
        title:  Text(
          'Add New Product',
          style: TextStyle(
             color: Theme.of(context).textTheme.titleLarge?.color,
             fontWeight: FontWeight.bold,
             fontSize: 16.sp
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
              buildTextField('Name', _nameController),
               SizedBox(height: 12.h),
              buildTextField('Name Arabic', _nameArabicController),
               SizedBox(height: 12.h),
              buildTextField('Image URL', _imagecontroller),
               SizedBox(height: 12.h),
              buildTextField('Price', _priceController, keyboardType: TextInputType.number),
               SizedBox(height: 12.h),
              buildTextField('Stock', _stockController, keyboardType: TextInputType.number),
               SizedBox(height: 12.h),
              buildTextField('Color', _colorController),
               SizedBox(height: 12.h),
              buildTextField('Description', _descController, maxLines: 2),
               SizedBox(height: 12.h),
              buildTextField('Description Arabic', _descArabicController, maxLines: 2),
              
               SizedBox(height: 20.h),
              
              
              SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
              onPressed: addProductt,
              icon: const Icon(Icons.add,color: Colors.white),
              label:  Text(
              'Add Product',
              style: TextStyle(fontSize: 18.sp,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
              ),
              ),
              ),
              ),
                SizedBox(height: 50.h),
              ],
              ),
            ),
            ),
      ),

    );
  }

  Widget buildTextField(
      String label,
      TextEditingController controller,
       {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
         SizedBox(height: 6.h),
        TextFormField(
          validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
          
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}