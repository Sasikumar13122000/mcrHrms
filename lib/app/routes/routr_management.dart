import 'package:get/get.dart';
import 'package:mrchrms/app/routes/navigation.dart';


abstract class RouteManageMent{
  static void goToSplash(){
    Get.offNamed(Routes.SPLASH_SCREEN);
  }

  static void goToLogin(){
    Get.offNamed(Routes.LOGIN_PAGE);
  }
  static void goToDash(){
    Get.offNamed(Routes.DASH_BARD);
  }

  static void goToAttendance(){
    Get.toNamed(Routes.ATTENDANCE_PAGE,arguments: <String,dynamic>{});
  }

  static void goToPermision(){
    Get.toNamed(Routes.PERMISION_MASTER,arguments: <String,dynamic>{});
  }


  static void goToOnduty(){
    Get.toNamed(Routes.ONDUTY_MASTER,arguments: <String,dynamic>{});
  }


  static void goToAttendanceReport(){
    Get.toNamed(Routes.ATTENDANCE_REPORT,arguments: <String,dynamic>{});
  }

  static void goToPermisionReport(){
    Get.toNamed(Routes.PERMISTION_REPORT,arguments: <String,dynamic>{});
  }


  static void goToOndutyReport(){
    Get.toNamed(Routes.ONDUTY_REPORT,arguments: <String,dynamic>{});
  }

  static void goToReport(){
    Get.toNamed(Routes.REPORTS_PAGES,arguments: <String,dynamic>{});
  }


  static void goToLeaveRequest(){
    Get.toNamed(Routes.LEAVE_REQUEST,arguments: <String,dynamic>{});
  }



  //
  // static void goToPurchaseOrder(){
  //   Get.toNamed(Routes.PURCHASE_ORDER,arguments: <String,dynamic>{
  //
  //   });
  // }



}

