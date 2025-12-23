import 'package:flutter/material.dart';
import '../widgets/otp_container.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.22), // أقل من قبل عشان العنوان أقرب للفوق
            // العنوان الرئيسي
            Text(
              'Enter Verification Code',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            // الفقرة تحت العنوان
            SizedBox(
              width: 243.5,
              child: Text(
                'We have sent a code to your email',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 13.6,
                  color: Color(0xFF9CA3AF),
                  height: 24 / 13.6, // line height
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 40),
            // حاوية الانبوت
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: OtpContainer(),
            ),
            SizedBox(height: 40),
            // زر Verify
            Container(
              width: 295,
              height: 49,
              decoration: BoxDecoration(
                color: Color(0xFFE83692),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 15.3,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Didn't receive code
            SizedBox(
              width: 327.2,
              child: Text(
                "Didn't receive code?",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 13.6,
                  color: Color(0xFF9CA3AF),
                  height: 24 / 13.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 4),
            // Resend Code
            SizedBox(
              width: 327.2,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 13.6,
                    color: Color(0xFFEC4899),
                    height: 24 / 13.6,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
