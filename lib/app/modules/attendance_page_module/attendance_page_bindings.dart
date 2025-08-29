
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/attendance_page_module/attendance_page_controller.dart';


class AttendancePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendancePageController());
  }
}