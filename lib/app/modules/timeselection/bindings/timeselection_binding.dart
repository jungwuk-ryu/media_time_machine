import 'package:get/get.dart';

import '../controllers/timeselection_controller.dart';

class TimeSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeSelectionController>(
      () => TimeSelectionController(),
    );
  }
}
