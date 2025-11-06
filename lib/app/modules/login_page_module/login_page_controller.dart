import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:mrchrms/app/data/repository/_allAPIList.dart';
import 'package:mrchrms/app/routes/routr_management.dart';
import 'package:mrchrms/app/utils/Utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart' as permision;


class LoginPageController extends GetxController {

  var userName = TextEditingController();
  var userPasword = TextEditingController();

  String? identifier;
  var location = Location();

  var passwordVisible = true;


  @override
  void onInit() {
    //TODO: implement onInit
    initUniqueIdentifierState();
    update();
    super.onInit();
  }

  // login() {
  //   Allapi.login(userName.text, userPasword.text, '', true).then((value) =>
  //   {
  //
  //     if(value.statusCode == 200){
  //       print(value.body),
  //       Utilities.closeLoader(),
  //       update(),
  //
  //       if(jsonDecode(value.body)['status'].toString() == "0"){
  //         Utilities.showDialaogboxAlert(
  //             Get.context, "Worng Credential", "Warring")
  //       } else
  //         {
  //           print(jsonDecode(value.body)['result'][0]['empID'].toString()),
  //           setSession(
  //               jsonDecode(value.body)['result'][0]['empID'].toString(),
  //               jsonDecode(value.body)['result'][0]['Lat'].toString(),
  //               jsonDecode(value.body)['result'][0]['Long'].toString(),
  //               jsonDecode(value.body)['result'][0]['Distance'].toString(),
  //               jsonDecode(value.body)['result'][0]['firstName'].toString(),
  //               jsonDecode(value.body)['result'][0]['dept'].toString(),
  //               jsonDecode(value.body)['result'][0]['Name'].toString(),
  //               jsonDecode(value.body)['result'][0]['Sex'].toString(),
  //               jsonDecode(value.body)['result'][0]['OffTel'].toString(),
  //               jsonDecode(value.body)['result'][0]['Mobile'].toString(),
  //               jsonDecode(value.body)['result'][0]['Email'].toString(),
  //               jsonDecode(value.body)['result'][0]['BankAc'].toString(),
  //               jsonDecode(value.body)['result'][0]['HomeSt'].toString(),
  //               jsonDecode(value.body)['result'][0]['HomeCity'].toString(),
  //               jsonDecode(value.body)['result'][0]['DOB'].toString(),
  //               jsonDecode(value.body)['result'][0]['MaStatus'].toString(),
  //               jsonDecode(value.body)['result'][0]['EmpType'].toString(),
  //               jsonDecode(value.body)['result'][0]['ExtEmpNo'].toString(),
  //               jsonDecode(value.body)['result'][0]['DOJ'].toString(),
  //               jsonDecode(value.body)['result'][0]['Type'].toString(),
  //               identifier,
  //               jsonDecode(value.body)['result'][0]['Manager'].toString()
  //           ),
  //         }
  //     } else
  //       {
  //         Utilities.showDialaogboxAlert(Get.context, "Server Error", "Error")
  //       }
  //   });
  // }

  login() {
    Allapi.login(userName.text, userPasword.text, '', true).then((value) async {
      if (value.statusCode == 200) {
        print(value.body);
        Utilities.closeLoader();
        update();

        final decoded = jsonDecode(value.body);

        if (decoded['status'].toString() == "0") {
          Utilities.showDialaogboxAlert(Get.context, "Wrong Credential", "Warning");
        } else {
          final result = decoded['result'][0];
          print(result['empID'].toString());

          // Handle multiple or single location
          String lat = "";
          String long = "";
          String distance = "";

          // Case 1: new API format -> Locations field exists
          if (result.containsKey('Locations') && result['Locations'] != null && result['Locations'].toString().isNotEmpty) {
            try {
              final List locations = jsonDecode(result['Locations'].toString());
              lat = locations[0]['Lat'].toString();
              long = locations[0]['Long'].toString();
              distance = locations[0]['Distance'].toString();

              final prefs = await SharedPreferences.getInstance();
              prefs.setString("Locations", jsonEncode(locations));
            } catch (e) {
              print("Error parsing multiple locations: $e");
            }
          }
          else {
            lat = result['Lat']?.toString() ?? "";
            long = result['Long']?.toString() ?? "";
            distance = result['Distance']?.toString() ?? "";
          }

          setSession(
            result['empID'].toString(),
            lat,
            long,
            distance,
            result['firstName'].toString(),
            result['dept'].toString(),
            result['Name']?.toString() ?? '',
            result['Sex']?.toString() ?? '',
            result['OffTel']?.toString() ?? '',
            result['Mobile']?.toString() ?? '',
            result['Email']?.toString() ?? '',
            result['BankAc']?.toString() ?? '',
            result['HomeSt']?.toString() ?? '',
            result['HomeCity']?.toString() ?? '',
            result['DOB']?.toString() ?? '',
            result['MaStatus']?.toString() ?? '',
            result['EmpType']?.toString() ?? '',
            result['ExtEmpNo']?.toString() ?? '',
            result['DOJ']?.toString() ?? '',
            result['Type']?.toString() ?? '',
            identifier,
            result['Manager']?.toString() ?? '',
          );
        }
      } else {
        Utilities.showDialaogboxAlert(Get.context, "Server Error", "Error");
      }
    });
  }



  Future<void> initUniqueIdentifierState() async {
    try {
      identifier = await UniqueIdentifier.serial;
      print(identifier);
      checkLocationPermission();
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }
  }

  Future<void> checkLocationPermission() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      Permission.location.request();
      //Permission.storage.request();
    }
  }

  Future<bool> locationpermisioncheck() async {
    bool enabled = await location.serviceEnabled();
    print(enabled);
    return enabled;
  }


  // setSession(userID, lat ,long ,Distance, firstName,
  //     deptCode, deptName, sex,
  //     offtell, mobile,
  //     email, bankac, homest, homecity, bob, marstatus,
  //     emptype, exempno, DOJ, Type, identifier,Manager,  ) async {
  //   var getintime='';
  //   getintime= DateFormat("hh:mm:ss a").format(DateTime.now());
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences prefs = await _prefs;
  //   prefs.setString("UserID", userID.toString());
  //   prefs.setString("Lat", lat.toString());
  //   prefs.setString("Long", long.toString());
  //   prefs.setString("Distance", Distance.toString());
  //   prefs.setString("FirstName", firstName.toString());
  //   prefs.setString("DeptCode", deptCode.toString());
  //   prefs.setString("DeptName", deptName.toString());
  //   prefs.setString("Sex", sex.toString());
  //   prefs.setString("OffTel", offtell.toString());
  //   prefs.setString("Mobile", mobile.toString());
  //   prefs.setString("Email", email.toString());
  //   prefs.setString("BankAc", bankac.toString());
  //   prefs.setString("HomeSt", homest.toString());
  //   prefs.setString("HomeCity", homecity.toString());
  //   prefs.setString("DOB", bob.toString());
  //   prefs.setString("MaStatus", marstatus.toString());
  //   prefs.setString("EmpType", emptype.toString());
  //   prefs.setString("ExtEmpNo", exempno.toString());
  //   prefs.setString("DOJ", DOJ.toString());
  //   prefs.setString("Type", Type.toString());
  //   prefs.setString("identifier", identifier.toString());
  //   prefs.setString("Manager", Manager.toString());
  //   prefs.setString("LoginTime", getintime.toString());
  //
  //   prefs.setString("Status", "Login");
  //   RouteManageMent.goToDash();
  // }


  setSession(
      userID,
      lat,
      long,
      Distance,
      firstName,
      deptCode,
      deptName,
      sex,
      offtell,
      mobile,
      email,
      bankac,
      homest,
      homecity,
      bob,
      marstatus,
      emptype,
      exempno,
      DOJ,
      Type,
      identifier,
      Manager,
      ) async {
    var getintime = DateFormat("hh:mm:ss a").format(DateTime.now());
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setString("UserID", userID.toString());
    prefs.setString("Lat", lat.toString());
    prefs.setString("Long", long.toString());
    prefs.setString("Distance", Distance.toString());
    prefs.setString("FirstName", firstName.toString());
    prefs.setString("DeptCode", deptCode.toString());
    prefs.setString("DeptName", deptName.toString());
    prefs.setString("Sex", sex.toString());
    prefs.setString("OffTel", offtell.toString());
    prefs.setString("Mobile", mobile.toString());
    prefs.setString("Email", email.toString());
    prefs.setString("BankAc", bankac.toString());
    prefs.setString("HomeSt", homest.toString());
    prefs.setString("HomeCity", homecity.toString());
    prefs.setString("DOB", bob.toString());
    prefs.setString("MaStatus", marstatus.toString());
    prefs.setString("EmpType", emptype.toString());
    prefs.setString("ExtEmpNo", exempno.toString());
    prefs.setString("DOJ", DOJ.toString());
    prefs.setString("Type", Type.toString());
    prefs.setString("identifier", identifier.toString());
    prefs.setString("Manager", Manager.toString());
    prefs.setString("LoginTime", getintime.toString());
    prefs.setString("Status", "Login");

    RouteManageMent.goToDash();
  }


  locationAleart(BuildContext context) async {

    //Geolocator.openLocationSettings();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want enable the Location"),
          actions: [
            TextButton(
              onPressed: (){
                Get.back();
                Geolocator.openLocationSettings();
                update();
              },
              child: const Text('Allow'),
            ),
            TextButton(
              onPressed: (){
                Get.back();
                update();
                },
              child: const Text('Deny'),
            )
          ],
        );
      },
    );
    update();
    //Utilities.showDialaogboxWarningMessage(Get.context, "Kindly Enable The Location", "Warning");
  }


  locationAleart1() async {
    Location location = new Location();
    bool ison = await location.serviceEnabled();
    if (!ison) { //if defvice is off
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        print("GPS device is turned ON");
      } else {
        print("GPS Device is still OFF");
      }
    }
  }

  void myPasswordVisible() {
    if(passwordVisible){
      passwordVisible = false;
    }else {
      passwordVisible = true;
    }
    update();
  }


}