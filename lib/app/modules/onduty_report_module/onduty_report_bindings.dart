import 'package:get/get.dart';
import 'package:mrchrms/app/modules/onduty_report_module/onduty_report_controller.dart';


class OndutyReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OndutyReportController());
  }
}