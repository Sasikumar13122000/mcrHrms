import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'attendance_page_controller.dart';

class AttendancePagePage extends GetView<AttendancePageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendancePageController>(builder: (controllermain) {
      final height = MediaQuery.of(context).size.height;
      final width = MediaQuery.of(context).size.width;

      if (controllermain.latlong == null) {
        return Scaffold(
          appBar: AppBar(title: Text("Attendance")),
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Attendance'),
            backgroundColor: Colors.redAccent,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: height / 60, width: width),
                Container(
                  height: height / 1.7,
                  width: width,
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: controllermain.latlong!,
                      zoom: 15.0,
                    ),
                    markers: <Marker>{
                      Marker(
                          markerId: const MarkerId('1'),
                          position: controllermain.latlong!,
                          infoWindow: const InfoWindow(title: 'My Position')),
                    },
                    onMapCreated: (GoogleMapController controller) {
                      controllermain.controller.complete(controller);
                    },
                  ),
                ),
                Card(
                  elevation: 5,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    children: [
                      _infoRow('Current Date', controllermain.getcurrendate,
                          width, height),
                      _infoRow('Login Time', controllermain.sessionLoginTime,
                          width, height),
                      _infoRow('Start Time', controllermain.StartTime, width,
                          height),
                      _infoRow(
                          'Name',
                          '${controllermain.sessionName}-${controllermain.sessionEmpId}',
                          width,
                          height),
                      _infoRow('Department Name',
                          controllermain.sessionDeptCode, width, height),
                      Card(
                        elevation: 5,
                        child: Container(
                          height: height / 30,
                          width: width / 1.1,
                          margin: EdgeInsets.only(left: width / 50),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controllermain.insetAddress.toString(),
                            style: TextStyle(
                                color: Colors.red.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: height / 30),
                  child: Material(
                    elevation: 2.0,
                    borderRadius:
                    BorderRadius.all(Radius.circular(height / 10)),
                    color: Colors.white,
                    shadowColor: Colors.black,
                    child: TextField(
                      controller: controllermain.attendanceRemarks,
                      cursorColor: Colors.black12,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      decoration: InputDecoration(
                          labelText: 'Remarks',
                          prefixIcon: Icon(Icons.comment, color: Colors.orange),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: height / 50)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: [
            Visibility(
              visible: controllermain.attendancestatus.toString() != "C",
              child: InkWell(
                onTap: () {
                  if (controllermain.attendancestatus.toString() == "0") {
                    _showStartDialog(context, controllermain);
                  } else {
                    _showStopDialog(context, controllermain);
                  }
                },
                child: Container(
                  height: height / 20,
                  width: width,
                  decoration: BoxDecoration(
                      color: controllermain.attendancestatus.toString() == "0"
                          ? Colors.orangeAccent
                          : Colors.pinkAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(width / 7),
                        bottomRight: Radius.circular(width / 7),
                      )),
                  alignment: Alignment.center,
                  child: Text(
                    controllermain.attendancestatus.toString() == "0"
                        ? 'Start Attendance'
                        : 'Stop Attendance',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: height / 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _infoRow(String label, String value, double width, double height) {
    return Container(
      height: height / 25,
      width: width / 1.1,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: width / 50),
      child: Row(
        children: [
          SizedBox(
              width: width / 3,
              child: Text(label, style: TextStyle(color: Colors.black38))),
          Text(value),
        ],
      ),
    );
  }

  void _showStartDialog(
      BuildContext context, AttendancePageController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("DO YOU WANT TO START THE ATTENDANCE?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                controller.distancecculator("1");
                // controller.startattendance(context);
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('CANCEL'),
            )
          ],
        );
      },
    );
  }

  void _showStopDialog(
      BuildContext context, AttendancePageController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("DO YOU WANT TO STOP THE ATTENDANCE?"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                controller.locationpermisioncheck().then((value) => {
                  if (value)
                    {controller.distancecculator("2")}
                  else
                    {controller.locationAleart(context)}
                });
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('CANCEL'),
            )
          ],
        );
      },
    );
  }
}