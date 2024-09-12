import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/datetime_input.dart';

class ProgressController extends GetxController {
  static const platform =
      MethodChannel('com.jungwuk.phototimemachine.date_changer');

  RxInt finishCnt = RxInt(0);
  RxInt itemCnt = RxInt(0);
  Rxn<Uint8List> thumbnailData = Rxn();
  RxString oldDateStr = RxString("");
  RxString newDateStr = RxString("");
  RxBool showThumbnail = RxBool(true);

  @override
  void onInit() {
    super.onInit();
    Map<dynamic, dynamic> args = Get.arguments;
    List<AssetEntity> entities = args['assets'];
    itemCnt.value = entities.length;

    _performDateUpdate();
  }

  Future<void> _performDateUpdate() async {
    Map<dynamic, dynamic> args = Get.arguments;
    List<AssetEntity> assets = args['assets'];
    DateTimeInput year = args['year'];
    DateTimeInput month = args['month'];
    DateTimeInput day = args['day'];
    DateTimeInput hour = args['hour'];
    DateTimeInput minute = args['minute'];
    DateTimeInput second = args['second'];

    Map<AssetEntity, DateTime> assetNewDateTimeMap = {};

    for (AssetEntity asset in assets) {
      if (showThumbnail.isTrue) {
        thumbnailData.value = await asset.thumbnailData;
      } else {
        thumbnailData.value = null;
      }

      DateTime odt = asset.createDateTime;
      DateTime ndt = DateTime(
          year.calcValue(odt.year),
          month.calcValue(odt.month),
          day.calcValue(odt.day),
          hour.calcValue(odt.hour),
          minute.calcValue(odt.minute),
          second.calcValue(odt.second));

      assetNewDateTimeMap[asset] = ndt;

      oldDateStr.value = odt.toString();
      newDateStr.value = ndt.toString();

      try {
        await changePhotoDate(asset, ndt);
      } catch (e) {
        log(e.toString()); // TODO: 예외처리
      }

      finishCnt++;
      //dd.value = null;
      oldDateStr.value = "";
      newDateStr.value = "";
    }

    Get.offAndToNamed(Routes.FINISH,
        arguments: {'assets': assets, 'newDateTime': assetNewDateTimeMap});
  }

  Future<void> changePhotoDate(AssetEntity asset, DateTime newDate) async {
    try {
      final bool success = await platform.invokeMethod('changePhotoDate', {
        'assetId': asset.id,
        'newDate': newDate.millisecondsSinceEpoch,
      });
      log(success ? 'Date changed successfully' : 'Failed to change date');
    } on PlatformException catch (e) {
      log("Failed to change photo date: '${e.message}'.");
    }
  }
}
