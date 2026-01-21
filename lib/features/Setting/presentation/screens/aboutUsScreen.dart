import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
               SizedBox(height: 50.h),

              Center(
                child: Image.asset(
                  'assets/images/OIP.jpg',
                  width: 70.w,
                  height: 70.h,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Shop Smart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

               Text(
                'Version 1.0.0',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),

               SizedBox(height: 24.h),
              Container(
                padding:  EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 16.h,
                ),
                child:  Text(
                  'ShopApp is your premier destination for all things lifestyle. We believe in quality, transparency, and exceptional customer service. Our mission is to bring the world\'s best products directly to your doorstep with just a few taps.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.8,
                    color: Color(0xFF5A5D63),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

               SizedBox(height: 25.h),

              Container(
                padding:  EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffFBE0EE),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _InfoTile(
                      icon: Icons.language,
                      title: 'Website',
                      subtitle: 'www.shopapp.com',
                    ),
                    SizedBox(height: 10.h),
                    _InfoTile(
                      icon: Icons.location_on,
                      title: 'Headquarters',
                      subtitle: '123 Commerce St, Tech City',
                    ),
                    SizedBox(height: 10.h),

                    _InfoTile(
                      icon: Icons.phone,
                      title: 'Contact',
                      subtitle: '+20 10********',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink, size: 22.sp),
           SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
               SizedBox(height: 4.h),
              Text(
                subtitle,
                style:  TextStyle(fontSize: 13.sp, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}