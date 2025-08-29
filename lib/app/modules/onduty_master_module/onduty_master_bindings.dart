import 'package:get/get.dart';
import 'package:mrchrms/app/modules/onduty_master_module/onduty_master_controller.dart';


class OndutyMasterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OndutyMasterController());
  }
}