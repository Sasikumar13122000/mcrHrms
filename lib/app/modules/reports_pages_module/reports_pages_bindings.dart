import 'package:get/get.dart';
import 'package:mrchrms/app/modules/reports_pages_module/reports_pages_controller.dart';

class ReportsPagesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportsPagesController());
  }
}