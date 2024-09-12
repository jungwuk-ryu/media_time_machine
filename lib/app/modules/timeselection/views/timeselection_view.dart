import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/app_button.dart';
import '../controllers/timeselection_controller.dart';

enum InputMode { set, add, sub }

class TimeSelectionView extends GetView<TimeSelectionController> {
  final RxBool _buttonEnable = true.obs;
  TimeSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Date & Time'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: _body())),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
            child: ListView.separated(
          itemCount: controller.listViewItems.length,
          itemBuilder: (BuildContext context, int index) {
            return controller.listViewItems[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            if (index < controller.assetContainerStartIndex) {
              return const SizedBox.shrink();
            }
            return const Divider();
          },
        )),
        SizedBox(height: 10.h),
        Obx(() => AppButton(
          text: _buttonEnable.isTrue ? 'Next' : 'Loading...',
          color: _buttonEnable.isTrue ? null : Colors.grey,
          func: () {
            if (_buttonEnable.isFalse) return;
            _buttonEnable.value = false;

            controller.onNextButtonClicked();
          },
        ),)
      ],
    );
  }
}
