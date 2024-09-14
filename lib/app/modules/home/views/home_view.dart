import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_timemachine/app/widgets/bordered_container.dart';
import 'package:photo_timemachine/app/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';

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
        const Spacer(),
        SizedBox(height: 10.h),
        Container(
          margin: EdgeInsets.all(10.r),
          child:        BorderedContainer(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child:               Shimmer.fromColors(
                    baseColor: Colors.grey.shade900,
                    highlightColor: Colors.grey.shade400,
                    child: const TitleText(
                      "Media Time Machine",
                    )),
              ),
              SizedBox(height: 10.h),
              const Divider(height: 0,),
              SizedBox(height: 10.h),
              const Text("💡About this app",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10.h),
              const Text(
                  "This app is a tool that allows you to easily change the date of your photos and videos. Tap the button below to select your media and enter the desired date.")
            ],
          )),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            controller.onButtonClick();
          },
          child: Container(
            width: double.infinity,
            height: 40.h,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                color: const Color(0xDF000000),
                borderRadius: BorderRadius.circular(20.r)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: const Center(
                  child: Text(
                    "Select Media",
                    style: TextStyle(color: Color(0xFFF8F8F8)),
                  ),
                )),
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () {
            showLicensePage(context: Get.context!);
          },
          child: const Text("Licenses",
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.underline)),
        )
      ],
    );
  }
}
