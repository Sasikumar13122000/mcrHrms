
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/permision_master_module/permision_master_controller.dart';


class PermisionMasterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermisionMasterController());
  }
}