import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_timemachine/app/routes/app_pages.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomeController extends GetxController {
  Future<void> onButtonClick() async {
    selectMedia();
  }

  Future<void> selectMedia() async {
    // 사진 라이브러리 접근 권한 요청
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();

    if (permission.isAuth) { // 권한 OK
      int pageSize = 80;
      // 최소 1, 최대 8
      int gridCount = max(1, min(8, MediaQuery.of(Get.context!).size.width ~/ 90));

      // pageSize % gridCount는 0 이어야 함
      while (pageSize % gridCount != 0) {
        gridCount --;
      }

      final List<AssetEntity>? photos = await AssetPicker.pickAssets(
          Get.context!,
          pickerConfig: AssetPickerConfig(
              specialPickerType: SpecialPickerType.noPreview,
              maxAssets: 100000,
              themeColor: Colors.lightBlueAccent,
              pageSize: pageSize,
              gridCount: gridCount,
              sortPathsByModifiedDate: true));

      if (photos != null && photos.isNotEmpty) {
        Get.toNamed(Routes.TIMESELECTION, arguments: photos);
      }
    } else { // 권한 없음
      Get.snackbar(
        "Permission Denied",
        "Permission not granted. Please enable it in settings.",
        mainButton: TextButton(
          onPressed: () {
            PhotoManager.openSetting();
          },
          child: const Text("Open Settings"),
        ),
      );
    }
  }
}
