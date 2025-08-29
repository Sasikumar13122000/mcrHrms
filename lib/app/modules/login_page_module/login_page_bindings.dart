
import 'package:get/get.dart';
import 'package:mrchrms/app/modules/login_page_module/login_page_controller.dart';


class LoginPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPageController());
  }
}