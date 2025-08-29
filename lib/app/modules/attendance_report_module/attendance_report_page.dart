import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrchrms/app/IncludeFiles/_appbar.dart';
import 'package:mrchrms/app/modules/attendance_report_module/attendance_report_controller.dart';


class AttendanceReportPage extends GetView<AttendanceReportController> {
  @override
  Widget build(BuildContext context)=>GetBuilder<AttendanceReportController>(builder: (myController) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: height/10,
                width: width,
                alignment: Alignment.center,
                child: MyAppBar(screenName: 'Attendance Reports',),
              ),
              Container(
                height: height/1.2,
                width: width/1.1,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      headingRowHeight: height/ 30,
                      headingRowColor: MaterialStateProperty.all(Colors.blue),
                      dataRowHeight: height/ 25,
                      border: TableBorder.all(color: Colors.green.shade50),
                      showCheckboxColumn: false,
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Name', style: TextStyle(color: Colors.white),),),
                        DataColumn(label: Text('Date', style: TextStyle(color: Colors.white),),),
                        DataColumn(label: Text('From Time', style: TextStyle(color: Colors.white),),),
                        DataColumn(label: Text('To Time', style: TextStyle(color: Colors.white),),),
                        DataColumn(label: Text('Status', style: TextStyle(color: Colors.white),),),
                      ],
                      rows: myController.secScreenData .map((list) =>
                          DataRow(
                            cells: [
                              DataCell(
                                Text(list.nAME.toString(),),
                              ),
                              DataCell(
                                Text(list.dATE.toString(),),
                              ),
                              DataCell(
                                Text(list.fROMTIME.toString(),),
                              ),
                              DataCell(
                                Text(list.tOTIME.toString(),),
                              ),
                              DataCell(
                                Text(list.aTTENDANCESTATUS.toString()=="P"?"Present":
                                list.aTTENDANCESTATUS.toString()=="H"?"HalfDay":"Absent",),
                              ),

                            ],
                          ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),

      ),
    );
  });
}
