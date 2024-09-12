import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class FinishController extends GetxController {
  late List<AssetEntity> assets;
  late Map<AssetEntity, DateTime> assetNewDateTimeMap;
  int cnt = 0;

  @override
  void onInit() {
    super.onInit();
    Map<dynamic, dynamic> args = Get.arguments;
    assets = args['assets'];
    assetNewDateTimeMap = args['newDateTime'];

    cnt = assets.length;
  }

  void exitPage() {
    Get.back();
  }

  String getAssetNewDateString(AssetEntity asset) {
    return (assetNewDateTimeMap[asset]?.toString()) ?? "";
  }
}
