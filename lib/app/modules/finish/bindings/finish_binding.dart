import 'package:get/get.dart';

import '../controllers/finish_controller.dart';

class FinishBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FinishController>(
      () => FinishController(),
    );
  }
}
