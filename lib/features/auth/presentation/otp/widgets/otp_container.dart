import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // عشان نستخدم الـ input formatter

class OtpContainer extends StatefulWidget {
  const OtpContainer({super.key});

  @override
  State<OtpContainer> createState() => _OtpContainerState();
}

class _OtpContainerState extends State<OtpContainer> {
  final int length = 6; // عدد خانات OTP
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  String otpCode = '';

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      // انتقل للمربع التالي لو مش اخر مربع
      if (index < length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus(); // لو اخر مربع
      }
    } else {
      // انتقل للمربع السابق لو مش اول مربع
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }

    // جمع كل الأرقام في متغير واحد
    otpCode = controllers.map((c) => c.text).join();
    print("Current OTP: $otpCode"); // لمتابعة الكود أثناء الكتابة
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(length, (index) {
        return Container(
          width: 48,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFBEBEBE), width: 1),
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // قبول الأرقام بس
              LengthLimitingTextInputFormatter(1), // خانة واحدة فقط
            ],
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            onChanged: (value) => _onChanged(value, index),
          ),
        );
      }),
    );
  }
}
