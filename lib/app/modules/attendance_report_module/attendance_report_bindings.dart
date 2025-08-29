
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/attendance_report_module/attendance_report_controller.dart';


class AttendanceReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendanceReportController());
  }
}