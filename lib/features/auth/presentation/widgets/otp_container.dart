import 'package:flutter/material.dart';

class OtpContainer extends StatelessWidget {
  const OtpContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 48,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFBEBEBE), width: 1),
          ),
          child: TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
          ),
        );
      }),
    );
  }
}
