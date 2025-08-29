
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/dash_bard_module/dash_bard_controller.dart';


class DashBardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashBardController());
  }
}