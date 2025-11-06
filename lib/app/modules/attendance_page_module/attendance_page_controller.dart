import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../data/repository/_allAPIList.dart';
import '../../utils/Utilites.dart';

class AttendancePageController extends GetxController {
  static AttendancePageController instance = Get.find();

  late Position position;
  LatLng? latlong;

  RxString insetlat = "0".obs;
  var insetlon = '0'.obs;
  var insetAddress = '0'.obs;
  var insetlocation = '0'.obs;

  var sessionUseId = '';
  var sessionLat = '';
  var sessionLong = '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionEmpId = '';
  var sessionidentifier = '';
  var actualDocNoFromStartAttendance = '';
  List<dynamic> allowedLocations = [];

  Completer<GoogleMapController> controller = Completer();

  var checkStatus;
  var attendancestatus = ''.obs;
  var getintime = '';
  var getouttime = '';
  var getcurrendate = '';
  var attendanceCloseDocNo = "0".obs;
  var StartTime = '';
  var sessionLoginTime = '';
  var sessiondistance = '';
  var netWorkImages = '';

  var attendanceRemarks = TextEditingController();


  @override
  void onInit() {
    getintime = DateFormat("hh:mm:ss a").format(DateTime.now());
    getouttime = DateFormat("hh:mm:ss a").format(DateTime.now());
    getcurrendate = DateFormat("dd-MM-yyyy").format(DateTime.now());
    // log("$getcurrendate $getintime");
    getStringValuesSF();
    super.onInit();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionUseId = prefs.getString('UserID').toString();
    sessionLat = prefs.getString('Lat').toString();
    sessionLong = prefs.getString('Long').toString();
    sessionName = prefs.getString('FirstName').toString();
    sessionDeptCode = prefs.getString('DeptCode').toString();
    sessionDeptName = prefs.getString('DeptName').toString();
    sessionEmpId = prefs.getString('ExtEmpNo').toString();
    sessionidentifier = prefs.getString('identifier').toString();
    sessionLoginTime = prefs.getString('LoginTime').toString();
    sessiondistance = prefs.getString('Distance').toString();

    String? locJson = prefs.getString('Locations');
    if (locJson != null && locJson.isNotEmpty) {
      try {
        allowedLocations = jsonDecode(locJson);
        print("✅ Parsed multiple office locations: ${allowedLocations.length}");
        print("✅   sessionLat sessionLat: ${sessionLat}");
        print("✅ Parsed  sessionLong sessionLong: ${sessionLong}");
        print("✅ Parsed multiple office locations: ${allowedLocations.toString()}");
      } catch (e) {
        print("❌ Error parsing Locations JSON: $e");
      }
    } else {
      print("⚠️ No multiple office locations found in session.");
    }

    update();
    await checkPermissionAndFetchLocation();
    print("distancesasas::"+sessiondistance);

  }



  Future<void> checkPermissionAndFetchLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return;
    }

    Utilities.showMapLoader();
    getLocation();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latlong = LatLng(position.latitude, position.longitude);
    insetlat.value = position.latitude.toString();
    insetlon.value = position.longitude.toString();
    update();
    _getAddressFromLatLng(position.latitude, position.longitude, position);
  }


  Future<void> _getAddressFromLatLng(
      double lat, double lang, Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      insetAddress.value =
      '${place.street}, ${place.subLocality}, ${place.locality},${place.administrativeArea}, ${place.postalCode}';
      insetlocation.value = place.subLocality.toString();

      checkattendance();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }


  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000; // distance in meters
  }

  Future<void> distancecculator(String formid) async {
    try {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print("📍 Current Location: ${position.latitude}, ${position.longitude}");

      bool isInsideAnyLocation = false;

      for (var loc in allowedLocations) {
        double officeLat = double.tryParse(loc['Lat'].toString()) ?? 0.0;
        double officeLng = double.tryParse(loc['Long'].toString()) ?? 0.0;
        double allowedRadius = double.tryParse(loc['Distance'].toString()) ?? 100.0;

        double distance = _calculateDistance(
          officeLat,
          officeLng,
          position.latitude,
          position.longitude,
        );

        print("📍 Checking ${loc['Location']} -> Distance: ${distance.toStringAsFixed(2)} m (Allowed: $allowedRadius m)");

        if (distance <= allowedRadius) {
          print("✅ Inside location: ${loc['Location']}");
          isInsideAnyLocation = true;

          // ✅ Pass the matched location info to attendance
          if (formid == "1") {
            startattendancee(
              matchedLocationName: loc['Location'].toString(),
              matchedLat: officeLat,
              matchedLong: officeLng,
            );
          } else if (formid == "2") {
            stopattendance(
              matchedLocationName: loc['Location'].toString(),
              matchedLat: officeLat,
              matchedLong: officeLng,
            );
          }
          break;
        }
      }

      if (!isInsideAnyLocation) {
        Utilities.alertsnackBar('Opps...!', 'You Are Too Far from Any Office Location', 2);
        print("❌ Not inside any allowed office location");
      }
    } catch (e) {
      print("⚠️ Error in distancecculator: $e");
    }
  }


  //old

  // Future<void> distancecculator(String formid) async {
  //
  //   // Get current position
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //
  //
  //
  //   validateAttendance(
  //     officeLat: double.parse(sessionLat),
  //     officeLng: double.parse(sessionLong),
  //     currentLat: position.latitude,
  //     currentLng: position.longitude,
  //     formid: formid
  //   );
  // }
  //
  // void validateAttendance({
  //   required double officeLat,
  //   required double officeLng,
  //   required double currentLat,
  //   required double currentLng,
  //   required String formid,
  //   double ? allowedRadius ,
  // }) {
  //
  //   double effectiveRadius =
  //       double.tryParse(sessiondistance ?? '100') ?? 100;
  //
  //
  //   double distance = _calculateDistance(
  //     officeLat,
  //     officeLng,
  //     currentLat,
  //     currentLng,
  //   );
  //   print("SASASdistance::${distance}");
  //   print("SASASallowedRadius::${effectiveRadius}");
  //   print("effectiveRadius::${effectiveRadius}");
  //   if (distance <= effectiveRadius){
  //     print("You are inside the office ✅ ");
  //
  //     if(formid=="1"){
  //       startattendancee();
  //     }else if (formid=="2"){
  //       stopattendance();
  //     }
  //   } else {
  //     Utilities.alertsnackBar('Opps...!', 'You Are Too Far from Our Office Location', 2);
  //     print("Go inside the office ❌");
  //   }
  // }



  checkattendance() {
    Map<String, dynamic> checkData = {
      "formid": 3,
      "name": sessionName,
      "empId": sessionUseId,
      "date": getcurrendate,
      "day": "$getcurrendate $getintime",
      "frmlatlong": "$insetlat,$insetlon",
      "fromplace": insetAddress.toString(),
      "tolatlng": '',
      "toplace": '',
      "totaldistance": '',
      "month": '',
      "remarks": attendanceRemarks.text,
      "createby": sessionUseId,
      "modifiedBy": '',
      "approvestatus": '0',
      "locationtype": insetlocation.toString(),
      "locationnanme": '',
      "description": sessionidentifier,
      "fromtime": getintime,
      "totime": '',
      "finalstatus": 'HalfDay',
      "maxDocNo": ''
    };

    // log("CHECK ATTENDANCE - Sending data: ${jsonEncode(checkData)}");

    Allapi.postattendance(
      false,
      3,
      sessionName,
      sessionUseId,
      getcurrendate,
      "$getcurrendate $getintime",
      "$insetlat,$insetlon",
      insetAddress.toString(),
      '',
      '',
      '',
      '',
      attendanceRemarks.text,
      sessionUseId,
      '',
      '0',
      insetlocation.toString(),
      '',
      sessionidentifier,
      getintime,
      '',
      'HalfDay',
      '',
    ).then((value) {
      if (value.statusCode == 200) {
        final decoded = jsonDecode(value.body);
        attendancestatus.value = decoded['status'].toString();

        if (decoded['status'] == 1 &&
            decoded['result'] != null &&
            decoded['result'].isNotEmpty) {
          var data = decoded['result'][0];

          if (data['status'] == 1) {
            attendancestatus.value = data['AttendanceStatus']?.toString() ?? '';
            attendanceCloseDocNo.value = data['DOCNO']?.toString() ?? '';
            StartTime = data['FROMTIME']?.toString() ?? '';
            attendanceRemarks.text = data['REMARKS']?.toString() ?? '';
            netWorkImages = data['IMAGEPATH']?.toString() ?? '';
          } else {
            StartTime = '';
          }
        } else {
          StartTime = '';
        }

        Utilities.closeLoader();
        update();
      }
    });
  }


  // Future<void> startattendancee() async {
  //   print("You are inside the startattendancee ✅ ");
  //   Map<String, dynamic> startData = {
  //     "formid": 1,
  //     "name": sessionName,
  //     "empId": sessionUseId,
  //     "date": "$getcurrendate $getintime",
  //     "day": "$getcurrendate $getintime",
  //     "frmlatlong": "$insetlat,$insetlon",
  //     "fromplace": insetAddress.toString(),
  //     "tolatlng": '',
  //     "toplace": '',
  //     "totaldistance": '',
  //     "month": '',
  //     "remarks": attendanceRemarks.text,
  //     "createby": sessionUseId,
  //     "modifiedBy": '',
  //     "approvestatus": '0',
  //     "locationtype": insetlocation.toString(),
  //     "locationnanme": '',
  //     "description": sessionidentifier,
  //     "fromtime": getintime,
  //     "totime": '',
  //     "finalstatus": 'HalfDay',
  //     "maxDocNo": ''
  //   };
  //
  //   try {
  //     final value = await Allapi.postattendance(
  //       true,
  //       1,
  //       sessionName,
  //       sessionUseId,
  //       "$getcurrendate $getintime",
  //       "$getcurrendate $getintime",
  //       "$insetlat,$insetlon",
  //       insetAddress.toString(),
  //       '',
  //       '',
  //       '',
  //       '',
  //       attendanceRemarks.text,
  //       sessionUseId,
  //       '',
  //       '0',
  //       insetlocation.toString(),
  //       '',
  //       sessionidentifier,
  //       getintime,
  //       '',
  //       'HalfDay',
  //       '',
  //     );
  //
  //     if (value.statusCode == 200) {
  //       var res = jsonDecode(value.body);
  //       checkStatus = res['status'] == 0 ? false : true;
  //
  //       if (!checkStatus) {
  //         Utilities.alertsnackBar('Error', res['result'].toString(), 2);
  //       } else {
  //         if (res['result'] is List && res['result'].isNotEmpty) {
  //           Utilities.showDialaogboxSavedMessage(
  //             Get.context!, //  Use Get.context safely
  //             res['result'][0]['STATUSNAME'].toString(),
  //             'Success',
  //           );
  //           Future.delayed(const Duration(seconds: 2), () {
  //             Get.offAllNamed('/dash_bard');
  //           });
  //           checkattendance();
  //         } else {
  //           Utilities.alertsnackBar('Error', 'Invalid response format', 2);
  //         }
  //       }
  //       update(); // refresh controller observers
  //     }
  //   } catch (e) {
  //     Utilities.alertsnackBar('Error', e.toString(), 2);
  //   }
  // }


  Future<void> startattendancee({
    required String matchedLocationName,
    required double matchedLat,
    required double matchedLong,
  }) async {
    print("You are inside the startattendancee ✅ for $matchedLocationName");

    try {
      final value = await Allapi.postattendance(
        true,
        1, // formid
        sessionName,
        sessionUseId,
        "$getcurrendate $getintime",
        "$getcurrendate $getintime",
        "$insetlat,$insetlon", // actual user current location
        insetAddress.toString(), // fromplace
        "$matchedLat,$matchedLong", // tolatlng - official location
        matchedLocationName, // toplace - official name
        '',
        '',
        attendanceRemarks.text,
        sessionUseId,
        '',
        '0',
        insetlocation.toString(), // locationtype (current area)
        matchedLocationName, // locationnanme (official site name)
        sessionidentifier,
        getintime,
        '',
        'HalfDay',
        '',
      );

      if (value.statusCode == 200) {
        var res = jsonDecode(value.body);
        checkStatus = res['status'] == 0 ? false : true;

        if (!checkStatus) {
          Utilities.alertsnackBar('Error', res['result'].toString(), 2);
        } else {
          if (res['result'] is List && res['result'].isNotEmpty) {
            Utilities.showDialaogboxSavedMessage(
              Get.context!,
              res['result'][0]['STATUSNAME'].toString(),
              'Success',
            );
            Future.delayed(const Duration(seconds: 2), () {
              Get.offAllNamed('/dash_bard');
            });
            checkattendance();
          } else {
            Utilities.alertsnackBar('Error', 'Invalid response format', 2);
          }
        }
        update();
      }
    } catch (e) {
      Utilities.alertsnackBar('Error', e.toString(), 2);
    }
  }


  // OLD

  // startattendance() async {
  //   Map<String, dynamic> startData = {
  //     "formid": 1,
  //     "name": sessionName,
  //     "empId": sessionUseId,
  //     "date": "$getcurrendate $getintime",
  //     "day": "$getcurrendate $getintime",
  //     "frmlatlong": "$insetlat,$insetlon",
  //     "fromplace": insetAddress.toString(),
  //     "tolatlng": '',
  //     "toplace": '',
  //     "totaldistance": '',
  //     "month": '',
  //     "remarks": attendanceRemarks.text,
  //     "createby": sessionUseId,
  //     "modifiedBy": '',
  //     "approvestatus": '0',
  //     "locationtype": insetlocation.toString(),
  //     "locationnanme": '',
  //     "description": sessionidentifier,
  //     "fromtime": getintime,
  //     "totime": '',
  //     "finalstatus": 'HalfDay',
  //     "maxDocNo": ''
  //   };
  //
  //   // log("START ATTENDANCE - Sending data: ${jsonEncode(startData)}");
  //
  //   Allapi.postattendance(
  //     true,
  //     1,
  //     sessionName,
  //     sessionUseId,
  //     "$getcurrendate $getintime",
  //     "$getcurrendate $getintime",
  //     "$insetlat,$insetlon",
  //     insetAddress.toString(),
  //     '',
  //     '',
  //     '',
  //     '',
  //     attendanceRemarks.text,
  //     sessionUseId,
  //     '',
  //     '0',
  //     insetlocation.toString(),
  //     '',
  //     sessionidentifier,
  //     getintime,
  //     '',
  //     'HalfDay',
  //     '',
  //   ).then((value) {
  //     if (value.statusCode == 200) {
  //       var res = jsonDecode(value.body);
  //       checkStatus = res['status'] == 0 ? false : true;
  //
  //       if (!checkStatus) {
  //         Utilities.alertsnackBar('Error', res['result'].toString(), 2);
  //       } else {
  //         if (res['result'] is List && res['result'].isNotEmpty) {
  //           Utilities.showDialaogboxSavedMessage(
  //             Get.context!, // ✅ Use Get.context safely
  //             res['result'][0]['STATUSNAME'].toString(),
  //             'Success',
  //           );
  //           Future.delayed(const Duration(seconds: 2), () {
  //             Get.offAllNamed('/dash_bard');
  //           });
  //           checkattendance();
  //         } else {
  //           Utilities.alertsnackBar('Error', 'Invalid response format', 2);
  //         }
  //       }
  //       update();
  //     }
  //   });
  // }

  // stopattendance(){
  //   // if(ImagePath==""){
  //   //   Utilities.showDialaogboxWarning(Get.context, "Add the selfie...", "Warning");
  //   //
  //   // }else{
  //   Allapi.postattendance(true,//isloading,
  //       2,// formid,
  //       sessionName,//name,
  //       sessionUseId,//empId,
  //       getcurrendate,//date,
  //       "$getcurrendate $getintime",//day,
  //       "$insetlat,$insetlon",//frmlatlong,
  //       insetAddress.toString(),//fromplace,
  //       "$insetlat,$insetlon",//tolatlng,
  //       insetAddress.toString(),//toplace,
  //       '',//totaldistance,
  //       '',//month,
  //       attendanceRemarks.text,//remarks,
  //       sessionUseId,//createby,
  //       '',//modifiedBy,
  //       '0',//approvestatus,
  //       insetlocation.toString(),//locationtype,
  //       insetlocation.toString(),//locationnanme,
  //       '',//description,
  //       getintime,//fromtime,
  //       getintime,//totime,
  //       'Present',//finalstatus
  //       attendanceCloseDocNo.toString() // maxDocNo
  //   ).then((value) => {
  //     // log(value.body),
  //     if(value.statusCode==200){
  //       Utilities.closeLoader(),
  //       checkStatus = jsonDecode(value.body)['status'] = 0,
  //       if(checkStatus==false){
  //         Utilities.alertsnackBar('Error','Somthing went wrong...',2),
  //         //Utilities.closeLoader(),
  //         update(),
  //       }else{
  //         // Utilities.alertsnackBar('Success',jsonDecode(value.body)['result'][0]['STATUSNAME'].toString(),3),
  //         // log(jsonDecode(value.body)['result'][0]['STATUSNAME'].toString()),
  //         Get.back(),
  //         // log("Close...."),
  //         //Utilities.closeLoader(),
  //         update(),
  //       }
  //     }
  //   });
  // }



  Future<void> stopattendance({
    required String matchedLocationName,
    required double matchedLat,
    required double matchedLong,
  }) async {
    print("You are inside the stopattendance ✅ for $matchedLocationName");

    try {
      final value = await Allapi.postattendance(
        true, // isloading
        2, // formid
        sessionName, // name
        sessionUseId, // empId
        getcurrendate, // date
        "$getcurrendate $getintime", // day
        "$insetlat,$insetlon", // frmlatlong (user current)
        insetAddress.toString(), // fromplace (user current address)
        "$matchedLat,$matchedLong", // tolatlng (office)
        matchedLocationName, // toplace
        '', // totaldistance
        '', // month
        attendanceRemarks.text, // remarks
        sessionUseId, // createby
        '', // modifiedBy
        '0', // approvestatus
        insetlocation.toString(), // locationtype (current area)
        matchedLocationName, // locationnanme (official site)
        sessionidentifier, // description
        getintime, // fromtime
        getouttime, // totime
        'Present', // finalstatus
        attendanceCloseDocNo.toString(), // maxDocNo
      );

      if (value.statusCode == 200) {
        var res = jsonDecode(value.body);
        checkStatus = res['status'] == 0 ? false : true;

        if (!checkStatus) {
          Utilities.alertsnackBar('Error', res['result'].toString(), 2);
        } else {
          Get.back(); // Close the attendance screen
          update();
        }
      }
    } catch (e) {
      Utilities.alertsnackBar('Error', e.toString(), 2);
    }
  }

  Future<bool> locationpermisioncheck() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    return enabled;
  }

  void locationAleart(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enable Location"),
          content: const Text(
            "Location services are disabled. Do you want to enable them?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Geolocator.openLocationSettings();
                update();
              },
              child: const Text('Allow'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                update();
              },
              child: const Text('Deny'),
            ),
          ],
        );
      },
    );
  }
}