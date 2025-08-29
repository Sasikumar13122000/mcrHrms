import 'package:get/get.dart';
import 'package:mrchrms/app/routes/routr_management.dart';


class ReportsPagesController extends GetxController{



  void getdashboardNavigation(int i) {
    if(i==7){
      RouteManageMent.goToAttendanceReport();
      update();
    }
    else if(i==8){
      RouteManageMent.goToPermisionReport();
      update();
    }
    else if(i==9){
      RouteManageMent.goToOndutyReport();
      update();
    }
  }
}
