import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_timemachine/app/widgets/bordered_container.dart';

import '../controllers/progress_controller.dart';

class ProgressView extends GetView<ProgressController> {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: _body(),
    )));
  }

  Widget _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Center(
          child: Obx(() {
            if (controller.thumbnailData.value == null) {
              return const SizedBox.shrink();
            }

            return Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color(0x64000000), blurRadius: 50, spreadRadius: 1)
              ]),
              child: Image.memory(controller.thumbnailData.value!),
            );
          }),
        )),
        BorderedContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Saving changes"),
              SizedBox(height: 10.h),
              _progressBar(),
              SizedBox(height: 5.h),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Obx(() => Text(
                      "${controller.finishCnt.value} / ${controller.itemCnt.value}")),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Show thumbnail",
                    style: TextStyle(
                        fontSize: 15.spMin, fontWeight: FontWeight.bold),
                  ),
                  Obx(() => Checkbox.adaptive(
                      value: controller.showThumbnail.value,
                      onChanged: (v) {
                        if (v == null) return;
                        controller.showThumbnail.value = v;
                        controller.thumbnailData.value = null;
                      }))
                ],
              ),
              SizedBox(height: 20.h),
              Text("Old Date",
                  style: TextStyle(
                      fontSize: 15.spMin, fontWeight: FontWeight.bold)),
              Obx(
                () => Text(controller.oldDateStr.value),
              ),
              const Divider(),
              Text(
                "New Date : ",
                style:
                    TextStyle(fontSize: 15.spMin, fontWeight: FontWeight.bold),
              ),
              Obx(
                () => Text(controller.newDateStr.value),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressBar() {
    double height = 8.h;

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: const Color(0xFFDBE0E5),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Obx(() {
            int fc = controller.finishCnt.value;
            int ic = controller.itemCnt.value;

            double width = fc / ic * constraints.maxWidth;

            return AnimatedContainer(
              width: width,
              height: height,
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: const Color(0xFF121417),
              ),
            );
          });
        },
      ),
    );
  }
}
