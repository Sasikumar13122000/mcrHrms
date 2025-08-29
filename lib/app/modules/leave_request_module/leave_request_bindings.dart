
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/leave_request_module/leave_request_controller.dart';


class LeaveRequestBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LeaveRequestController());
  }
}