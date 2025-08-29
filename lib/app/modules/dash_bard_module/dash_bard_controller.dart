import 'dart:math';

import 'package:get/get.dart';
import 'package:mrchrms/app/routes/routr_management.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;


class DashBardController extends GetxController{

  var sessionUseId  =   '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionType = '';
  var sessionEmpId = '';
  var sessionManager = '';
  int currentindex = 0;
  loc.Location location = loc.Location();
  late loc.PermissionStatus _permissionGranted;

  @override
  void onInit() {
    // TODO: implement onInit
    getStringValuesSF();
    update();
    super.onInit();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionUseId  =   prefs.getString('UserID').toString();
    sessionName = prefs.getString('FirstName').toString();
    sessionDeptCode = prefs.getString('DeptCode').toString();
    sessionDeptName = prefs.getString('DeptName').toString();
    sessionType = prefs.getString('Type').toString();
    sessionEmpId = prefs.getString('ExtEmpNo').toString();
    sessionManager = prefs.getString('Manager').toString();
    print(sessionType);
    permision();
    update();

    print("SASASASASessioon name :"+sessionName);
    print("SASASASASessioon sessionDeptName :"+sessionDeptName);
    print("SASASASASessioon sessionEmpId :"+sessionEmpId);
  }

  permision() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
    update();
  }

  getdashboardNavigation(int i) {

    if(i==1){
      pickImageWithPermission();
      //RouteManageMent.goToAttendance();
      update();
    }else if(i==2){
      //RouteManageMent.goToSiteVisit();
      update();
    }else if (i==3){
      //RouteManageMent.goToLeadPage("0","");
      update();
    }else if (i==4){
      //RouteManageMent.goToProductionHeader();
      update();
    }else if(i==5){
      RouteManageMent.goToPermision();
      update();
    }else if(i==6){
      RouteManageMent.goToOnduty();
      update();
    }
    else if(i==7){
      RouteManageMent.goToLeaveRequest();
      update();
    }
    else if(i==8){
      //RouteManageMent.goToPermisionReport();
      update();
    }
    else if(i==9){
      RouteManageMent.goToOndutyReport();
      update();
    }else if(i==10){
      RouteManageMent.goToReport();
    }
  }

  Future<void> exitPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('UserID', "");
    prefs.setString('FirstName', "");
    prefs.setString('DeptCode', "");
    prefs.setString('DeptName', "");
    prefs.setString("Status", "LoginOut");
    RouteManageMent.goToLogin();
  }


  Future pickImageWithPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    print(cameraPermissionStatus.isGranted);
    print(storagePermissionStatus.isGranted);

    if (cameraPermissionStatus.isGranted) {
      print("Camera Allow");
      RouteManageMent.goToAttendance();
      // Permissions are already granted, proceed to pick file
      //pickFile();
    } else {
      Map<Permission, PermissionStatus> permissionStatuses = await [
        Permission.camera,
        Permission.storage,
        Permission.manageExternalStorage,
      ].request();

      if (permissionStatuses[Permission.camera]!.isGranted) {
        RouteManageMent.goToAttendance();
        // Permissions granted, proceed to pick file
        //pickFile();
      } else {
        print("Camera Allow");
        //RouteManageMent.goToAttendance();
        // Permissions denied, handle accordingly (show an error message, request again, or emit your bloc state.)
        // ...
      }
    }
  }
}
