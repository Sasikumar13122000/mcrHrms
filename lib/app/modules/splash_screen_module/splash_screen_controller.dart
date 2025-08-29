import 'package:get/get.dart';
import 'package:mrchrms/app/routes/routr_management.dart';


class SplashScreenController extends GetxController{

  @override
  void onInit() {
    //TODO: implement onInit
    Future.delayed(const Duration(seconds: 5),(){
      RouteManageMent.goToLogin();
    });
    update();
    super.onInit();
  }
}
