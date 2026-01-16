import 'package:flutter/material.dart';
import 'dart:async'; // عشان نعمل عداد مؤقت

class ResendCodeButton extends StatefulWidget {
  final VoidCallback onResend; // الدالة اللي هتتنفذ لما يضغط المستخدم
  const ResendCodeButton({super.key, required this.onResend});

  @override
  State<ResendCodeButton> createState() => _ResendCodeButtonState();
}

class _ResendCodeButtonState extends State<ResendCodeButton> {
  bool canResend = true;
  int seconds = 30; // مؤقت إعادة الإرسال
  Timer? timer;

  void startTimer() {
    setState(() {
      canResend = false;
      seconds = 30;
    });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          canResend = true;
          t.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: canResend
          ? () {
              widget.onResend(); // هنا هتكتبي الدالة اللي تبعت الكود
              startTimer(); // شغلي المؤقت
            }
          : null, // لما يكون المؤقت شغال يبقي الزر غير مفعل
      child: Text(
        canResend ? 'Resend Code' : 'Resend in $seconds s',
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
          fontSize: 13.6,
          color: const Color(0xFFEC4899),
        ),
      ),
    );
  }
}
