import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_timemachine/app/widgets/asset_container.dart';
import 'package:photo_timemachine/app/widgets/title_text.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/datetime_input.dart';

class TimeSelectionController extends GetxController {
  final DateTimeInput year = DateTimeInput(text: "Year");
  final DateTimeInput month = DateTimeInput(text: "Month");
  final DateTimeInput day = DateTimeInput(text: "Day");
  final DateTimeInput hour = DateTimeInput(text: "Hour");
  final DateTimeInput minute = DateTimeInput(text: "Minute");
  final DateTimeInput second = DateTimeInput(text: "Second");
  late int assetContainerStartIndex;

  List<Widget> listViewItems = [];

  @override
  void onInit() {
    super.onInit();
    _buildListViewItems();
  }

  void _buildListViewItems() {
    listViewItems = [
      year,
      month,
      day,
      const Divider(),
      hour,
      minute,
      second,
      const Divider(),
      const TitleText('Preview'),
      SizedBox(height: 10.h),
      // 10
    ];
    assetContainerStartIndex = 10;

    List<AssetEntity> assets = Get.arguments;
    for (AssetEntity asset in assets) {
      listViewItems.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Obx(() {
            // listening
            year.listenChangesForObx();
            month.listenChangesForObx();
            day.listenChangesForObx();
            hour.listenChangesForObx();
            minute.listenChangesForObx();
            second.listenChangesForObx();

            // calc new date
            DateTime dt = asset.createDateTime;
            DateTime nDT = DateTime(
                year.calcValue(dt.year),
                month.calcValue(dt.month),
                day.calcValue(dt.day),
                hour.calcValue(dt.hour),
                minute.calcValue(dt.minute),
                second.calcValue(dt.second));

            return AssetContainer(asset, nDT.toString());
          })));
    }
  }

  void nextPage() {
    Get.offAndToNamed(Routes.PROGRESS, arguments: {
      'assets': Get.arguments,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'second': second,
    });
  }
}
