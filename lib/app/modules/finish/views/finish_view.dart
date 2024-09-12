import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_timemachine/app/widgets/app_button.dart';
import 'package:photo_timemachine/app/widgets/asset_container.dart';
import 'package:photo_timemachine/app/widgets/bordered_container.dart';
import 'package:photo_timemachine/app/widgets/title_text.dart';

import '../controllers/finish_controller.dart';

class FinishView extends GetView<FinishController> {
  const FinishView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: _body())),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Changes Applied"),
        SizedBox(height: 20.h),
        Expanded(
          child: BorderedContainer(ListView.separated(
            itemCount: controller.cnt,
            itemBuilder: (context, index) {
              AssetEntity asset = controller.assets[index];
              String newDateStr = controller.getAssetNewDateString(asset);

              return AssetContainer(asset, newDateStr);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          )),
        ),
        SizedBox(height: 10.h),
        AppButton(text: "Ok", func: () => controller.exitPage())
      ],
    );
  }
}
