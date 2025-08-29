import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/Model/LeaveTypeModel.dart';
import '../../data/repository/_allAPIList.dart';
import '../../utils/Utilites.dart';

class LeaveRequestController extends GetxController {
  TextEditingController fromdate = TextEditingController();
  TextEditingController todate = TextEditingController();
  TextEditingController nodays = TextEditingController();
  TextEditingController comments = TextEditingController();
  TextEditingController leaveType = TextEditingController();

  var leaveCode = '';
  late LeaveTypeModel rawLeaveTypeModel;
  List<LeaveTypeList> secLeaveTypeList = [];

  var text = "".obs;
  var datecount = '0';
  var sendfromdate = '';
  var sendtodate = '';

  var sessionUseId = '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionEmpId = '';
  double CasulaLeave = 0;
  double SLLeave = 0;
  double ELLeave = 0;
  double Comff = 0;
  int getDocNo = 0;

  @override
  void onInit() {
    var datecountdummy = '0';
    sendfromdate = DateFormat('yyyyMMdd').format(DateTime.now());
    sendtodate = DateFormat('yyyyMMdd').format(DateTime.now());
    fromdate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    todate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    datecount =
    "${DateTime.parse(sendtodate.toString()).difference(DateTime.parse(sendfromdate.toString())).inDays}";
    datecount = datecountdummy == '0' ? '1' : datecount;
    nodays.text = datecount.toString();
    getStringValuesSF();
    update();
    // TODO: implement onInit
    super.onInit();
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionUseId = prefs.getString('UserID').toString();
    sessionName = prefs.getString('FirstName').toString();
    sessionDeptCode = prefs.getString('DeptCode').toString();
    sessionDeptName = prefs.getString('DeptName').toString();
    sessionEmpId = prefs.getString('ExtEmpNo').toString();
    update();
    getLeaveType();
    //getLeave();
  }

  selectToDate(fromid, BuildContext context) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      if (fromid == 1) {
        fromdate.text = DateFormat('yyyy-MM-dd').format(picked);
        sendfromdate = DateFormat('yyyyMMdd').format(picked);
        todate.text = '';
        sendtodate = '';
        nodays.text = '';

        //datecount = "${DateTime.parse(sendtodate.toString()).difference(DateTime.parse(sendfromdate.toString())).inDays}";
        //nodays.text = datecount.toString();
      } else if (fromid == 2) {
        sendtodate = DateFormat('yyyyMMdd').format(picked);
        datecount =
        "${DateTime.parse(sendtodate.toString()).difference(DateTime.parse(sendfromdate.toString())).inDays}";
        log(datecount);
        if (int.parse(datecount.toString()) >= 0) {
          todate.text = DateFormat('yyyy-MM-dd').format(picked);
          nodays.text = datecount.toString() == "0"
              ? '1'
              : (int.parse(datecount.toString()) + 1).toString();
        } else {
          Utilities.showDialaogboxWarningMessage(
              context, "Choose based on from date", "Warring");
          todate.text = '';
          sendtodate = '';
          nodays.text = '';
        }
      }
    }
  }

  oFFdayCalc() {
    if (nodays.text == '1') {
      nodays.text = '0.5';
      update();
    } else {
      datecount =
      "${DateTime.parse(sendtodate.toString()).difference(DateTime.parse(sendfromdate.toString())).inDays}";
      nodays.text = datecount.toString() == "0"
          ? '1'
          : (int.parse(datecount.toString()) + 1).toString();
      update();
      //Utilities.showDialaogboxWarningMessage(Get.context, "No Of Days Should be One", "Warring");
    }
  }

  getLeaveType() {
    Allapi.indusAllmaster(5, 1, '', '', '', true).then((value) => {
      if (value.statusCode == 200)
        {
          log(value.body),
          rawLeaveTypeModel =
              LeaveTypeModel.fromJson(jsonDecode(value.body)),
          for (int i = 0; i < rawLeaveTypeModel.result!.length; i++)
            {
              secLeaveTypeList.add(
                LeaveTypeList(
                  rawLeaveTypeModel.result![i].leaveType.toString(),
                  rawLeaveTypeModel.result![i].leaveCode.toString(),
                ),
              ),
            },
          update(),
          Utilities.closeLoader(),
          getLeave(),
        }
    });
  }

  getLeave() {
    Allapi.insertLeaveMaster(
        1,
        sessionUseId,
        leaveType.text,
        leaveCode,
        fromdate.text,
        todate.text,
        nodays.text,
        comments.text,
        'P',
        getDocNo.toString(),
        true)
        .then((value) => {
      if (value.statusCode == 200)
        {
          log(value.body),
          if (jsonDecode(value.body)['status'].toString() == "0")
            {
              CasulaLeave = 0,
              ELLeave = 0,
              SLLeave = 0,
              Comff = 0,
            }
          else
            {
              CasulaLeave = double.parse(
                  jsonDecode(value.body)['result'][0]['TakenLeave']
                      .toString()),
              ELLeave = double.parse(jsonDecode(value.body)['result'][0]
              ['EmerLeave']
                  .toString()),
              SLLeave = double.parse(jsonDecode(value.body)['result'][0]
              ['SeekLeave']
                  .toString()),
              Comff = double.parse(jsonDecode(value.body)['result'][0]
              ['CompOff']
                  .toString()),
            },
          update(),
          Utilities.closeLoader(),
          if (getDocNo == 0)
            {}
          else
            {
              Allapi.getApprovelList(4, sessionUseId, "", "P",
                  getDocNo.toString(), true)
                  .then((value) => {
                if (value.statusCode == 200)
                  {
                    if (jsonDecode(value.body)['status']
                        .toString() ==
                        "0")
                      {
                        update(),
                        Utilities.closeLoader(),
                      }
                    else
                      {
                        log(value.body),
                        leaveType.text =
                        jsonDecode(value.body)['result'][0]
                        ['LeaveType'],
                        leaveCode =
                        jsonDecode(value.body)['result'][0]
                        ['LeaveCode'],
                        fromdate.text =
                        jsonDecode(value.body)['result'][0]
                        ['FromDate'],
                        todate.text =
                        jsonDecode(value.body)['result'][0]
                        ['Todate'],
                        nodays.text =
                        jsonDecode(value.body)['result'][0]
                        ['NoOfDays'],
                        comments.text =
                        jsonDecode(value.body)['result'][0]
                        ['Comments'],
                        update(),
                        Utilities.closeLoader(),
                      }
                  }
                else
                  {
                    update(),
                    Utilities.closeLoader(),
                  }
              }),
            }
        }
    });
  }

  postDataSave(fromId) {
    if (leaveType.text.isEmpty) {
      Utilities.showDialaogboxWarningMessage(
          Get.context, "LeaveType is not load...", 'Notification');
    } else if (leaveCode.isEmpty) {
      Utilities.showDialaogboxWarningMessage(
          Get.context, "LeaveType is not load...", 'Notification');
    } else if (fromdate.text.isEmpty) {
      Utilities.showDialaogboxWarningMessage(
          Get.context, "From Date is not Choose...", 'Notification');
    } else if (todate.text.isEmpty) {
      Utilities.showDialaogboxWarningMessage(
          Get.context, "To Date is not Choose...", 'Notification');
    } else if (nodays.text.isEmpty) {
      Utilities.showDialaogboxWarningMessage(
          Get.context, "NoOfDays is not load...", 'Notification');
    } else {
      if (leaveCode == "CL") {
        if (getDocNo == 0) {
          if (double.parse(nodays.text.toString()) >= 3) {
            Utilities.showDialaogboxWarningMessage(
                Get.context, "CL Available at one Days..", 'Notification');
          } else if (CasulaLeave >= 3) {
            Utilities.showDialaogboxWarningMessage(
                Get.context, "CL is Closed..", 'Notification');
          } else {
            Allapi.insertLeaveMaster(
                fromId,
                sessionUseId,
                leaveType.text,
                leaveCode,
                fromdate.text,
                todate.text,
                nodays.text,
                comments.text,
                'P',
                getDocNo.toString(),
                true)
                .then((value) => {
              if (value.statusCode == 200)
                {
                  log(value.body),
                  update(),
                  Utilities.closeLoader(),
                  Utilities.showDialaogboxSavedMessage(
                      Get.context,
                      jsonDecode(value.body)['result'][0]['StatusMesg']
                          .toString(),
                      'Saved..')
                }
            });
          }
        } else {
          if (CasulaLeave > 4) {
            Utilities.showDialaogboxWarningMessage(
                Get.context, "CL is Closed..", 'Notification');
          } else {
            Allapi.insertLeaveMaster(
                fromId,
                sessionUseId,
                leaveType.text,
                leaveCode,
                fromdate.text,
                todate.text,
                nodays.text,
                comments.text,
                'P',
                getDocNo.toString(),
                true)
                .then((value) => {
              if (value.statusCode == 200)
                {
                  log(value.body),
                  update(),
                  Utilities.closeLoader(),
                  Utilities.showDialaogboxSavedMessage(
                      Get.context,
                      jsonDecode(value.body)['result'][0]['StatusMesg']
                          .toString(),
                      'Saved..')
                }
            });
          }
        }
      } else if (leaveCode == "EL") {
        if (int.parse(nodays.text.toString()) < 3) {
          Utilities.showDialaogboxWarningMessage(
              Get.context, "CL Available at one Days..", 'Notification');
        } else if (ELLeave < 3) {
          Utilities.showDialaogboxWarningMessage(
              Get.context, "CL is Closed..", 'Notification');
        } else {
          Allapi.insertLeaveMaster(
              fromId,
              sessionUseId,
              leaveType.text,
              leaveCode,
              fromdate.text,
              todate.text,
              nodays.text,
              comments.text,
              'P',
              getDocNo.toString(),
              true)
              .then((value) => {
            if (value.statusCode == 200)
              {
                log(value.body),
                update(),
                Utilities.closeLoader(),
                Utilities.showDialaogboxSavedMessage(
                    Get.context,
                    jsonDecode(value.body)['result'][0]['StatusMesg']
                        .toString(),
                    'Saved..')
              }
          });
        }
      } else {
        Allapi.insertLeaveMaster(
            fromId,
            sessionUseId,
            leaveType.text,
            leaveCode,
            fromdate.text,
            todate.text,
            nodays.text,
            comments.text,
            'P',
            getDocNo.toString(),
            true)
            .then((value) => {
          if (value.statusCode == 200)
            {
              log(value.body),
              update(),
              Utilities.closeLoader(),
              Utilities.showDialaogboxSavedMessage(
                  Get.context,
                  jsonDecode(value.body)['result'][0]['StatusMesg']
                      .toString(),
                  'Saved..')
            }
        });
      }
    }
  }
}

class LeaveTypeList {
  String descripition;
  String code;
  LeaveTypeList(this.descripition, this.code);
}
