import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_timemachine/app/widgets/bordered_container.dart';
import 'package:photo_timemachine/app/widgets/title_text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: _body(),
      )),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(child: SizedBox()),
        const TitleText(
          "Media Time Machine ⏰",
        ),
        SizedBox(height: 10.h),
        BorderedContainer(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("💡About this app",
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10.h),
            const Text(
                "This app is a tool that allows you to easily change the date of your photos and videos. Tap the button below to select your media and enter the desired date.")
          ],
        )),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () {
            controller.onButtonClick();
          },
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            decoration: BoxDecoration(
                color: Colors.blue.shade200,
                borderRadius: BorderRadius.circular(10.r)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: const Center(
                  child: Text("Select Media"),
                )),
          ),
        ),
        const Expanded(child: SizedBox()),
        Row(
          children: [
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: () {
                showLicensePage(context: Get.context!);
              },
              child:
                  const Text("Licenses", style: TextStyle(color: Colors.grey)),
            ),
          ],
        )
      ],
    );
  }
}
