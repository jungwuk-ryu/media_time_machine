import 'package:get/get.dart';

import '../modules/finish/bindings/finish_binding.dart';
import '../modules/finish/views/finish_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/progress/bindings/progress_binding.dart';
import '../modules/progress/views/progress_view.dart';
import '../modules/timeselection/bindings/timeselection_binding.dart';
import '../modules/timeselection/views/timeselection_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TIMESELECTION,
      page: () => TimeSelectionView(),
      binding: TimeSelectionBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => const ProgressView(),
      binding: ProgressBinding(),
    ),
    GetPage(
      name: _Paths.FINISH,
      page: () => const FinishView(),
      binding: FinishBinding(),
    ),
  ];
}
