import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function() func;
  final Color? color;

  const AppButton(
      {super.key, required this.text, required this.func, this.color});

  @override
  Widget build(BuildContext context) {
    Color bcc = color ?? const Color(0xFF1A80E5);

    return GestureDetector(
      onTap: func,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
        width: double.infinity,
        height: 35.h,
        decoration: BoxDecoration(
            color: bcc, borderRadius: BorderRadius.circular(12.r)),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        child: Center(
          child: FittedBox(
              child: Text(
            text,
            style: TextStyle(
                color:
                    bcc.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
