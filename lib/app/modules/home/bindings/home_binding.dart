import 'package:get/get.dart';
import 'package:photo_timemachine/app/services/ad_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdService());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
