import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;

  const BorderedContainer(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFE3DEDE), width: 1.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: child);
  }
}
