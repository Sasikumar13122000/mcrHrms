
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/permistion_report_module/permistion_report_controller.dart';


class PermistionReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PermistionReportController());
  }
}