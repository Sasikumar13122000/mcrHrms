import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mrchrms/app/data/Model/TotalPermisionModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repository/_allAPIList.dart';
import '../../utils/Utilites.dart';


class PermisionMasterController extends GetxController{

  var sessionUseId  =   '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionEmpId = '';

  TextEditingController fromdate =TextEditingController();
  TextEditingController toTime =TextEditingController();
  TextEditingController fromTime =TextEditingController();
  TextEditingController totalTime =TextEditingController();
  TextEditingController comments =TextEditingController();
  TextEditingController perivouspermisionData =TextEditingController(text: '');

  TimeOfDay picked = TimeOfDay.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int getDocNo=0;

  int fromtime=0;
  int fromminist=0;
  int Toime=0;
  int Tominist=0;
  double TotalPermision=0;
  double TotalCount=0;
  double RemainingPermision=0;
  var startTime = 0;
  var startminist = 0;

  late TotalPermisionModel rawTotalPermisionModel;

   DateTime? calFromTime;
   DateTime? calToTime;


  @override
  void onInit() {
    fromdate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fromtime = TimeOfDay.now().hour;
    fromminist = selectedTime.minute;
    //getDocNo = Get.arguments['DocNo'];
    getStringValuesSF();
    update();
    // TODO: implement onInit
    super.onInit();
  }

  getStringValuesSF() async {
    log("message");
    SharedPreferences prefs =await SharedPreferences.getInstance();
    sessionUseId  =   prefs.getString('UserID').toString();
    sessionName = prefs.getString('FirstName').toString();
    sessionDeptCode = prefs.getString('DeptCode').toString();
    sessionDeptName = prefs.getString('DeptName').toString();
    sessionEmpId = prefs.getString('ExtEmpNo').toString();
    log(sessionName);
    update();
    getTotalPermision();
  }

  getTotalPermision(){
    var d;
    Allapi.insertPermisionMaster(1, "fromdate", "fromTime", "totime", "totalTime",
        sessionUseId, "docdate", "status", "purposeofvist", "docNo", true).then((value) => {
      if(value.statusCode==200){
        update(),
        log(value.body),
        Utilities.closeLoader(),

        TotalPermision = double.parse(jsonDecode(value.body)['result'][0]['TakenTime'].toString()),
        RemainingPermision = double.parse(jsonDecode(value.body)['result'][0]['Remaining'].toString()),
        print(RemainingPermision),

        TotalCount = double.parse(jsonDecode(value.body)['result'][0]['DocCount'].toString())+1,
        perivouspermisionData.text = jsonDecode(value.body)['result'][0]['Permision'].toString(),
        if(getDocNo==0){

        }else{
          Allapi.getApprovelList(5, sessionUseId, "", "P", getDocNo.toString(), true).then((value) => {
            if(value.statusCode==200){
              print(jsonDecode(value.body)['result'][0]['Permision'].toString()),
              if(jsonDecode(value.body)['status'].toString() == "0"){
                update(),
                Utilities.closeLoader(),
              }else{
                log(value.body),
                fromdate.text = jsonDecode(value.body)['result'][0]['FromDatee'],
                fromTime.text = jsonDecode(value.body)['result'][0]['FromTime'],
                toTime.text = jsonDecode(value.body)['result'][0]['ToTime'],
                totalTime.text = jsonDecode(value.body)['result'][0]['TotalTime'],
                comments.text = jsonDecode(value.body)['result'][0]['Purposeofvist'].toString(),

                print("object"),


                update(),
                Utilities.closeLoader(),
              }
            }else{
              update(),
              Utilities.closeLoader(),
            }
          }),
        }
      }
      else{
        update(),
        Utilities.closeLoader(),
      }
    });

  }

  selectToDate(fromid,BuildContext context)async {
    var picked = await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null) {
      if (fromid == 1) {
        fromdate.text = DateFormat('yyyy-MM-dd').format(picked);
        //fromdate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      } else if (fromid == 2) {

      }
    }
  }

  selectFromTime(BuildContext context) async {

    int hour=0;
    var minits='';
    var session='';

    picked = (await showTimePicker(initialTime: selectedTime, context: context))!;
    if(picked != null){
      selectedTime = picked;

      fromtime=0;
      fromminist=0;
      fromtime = selectedTime.hour;
      fromminist = selectedTime.minute;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var _date = dateFormat.format(DateTime.now());
      var time1 = (fromtime.toString()+":"+fromminist.toString());
      print(fromtime);
      print(fromminist);
      print(DateTime.parse('$_date $time1:00'));
      calFromTime = DateTime.parse('$_date $time1:00');

      if(selectedTime.hour>=12){

        //hour = int.parse(selectedTime.hour .toString()) - 12;
        hour = selectedTime.hour==12?12:int.parse(selectedTime.hour .toString()) - 12;
        //minits = selectedTime.minute .toString();
        minits = selectedTime.minute .toString().length==1?"0"+selectedTime.minute .toString():selectedTime.minute .toString();
        session = 'PM';
        //print(hour.toString()+":"+minits.toString()+"-"+session.toString());
        fromTime.text  = hour.toString()+":"+minits.toString()+"-"+session.toString();
        update();
        totalTimeCal();

      }else if (selectedTime.hour<12){
        // hour = selectedTime.hour;
        // minits = selectedTime.minute .toString();
        hour = selectedTime.hour==0?12:selectedTime.hour;
        minits = selectedTime.minute .toString().length==1?"0"+selectedTime.minute .toString():selectedTime.minute .toString();
        session = 'AM';
        print(hour.toString()+":"+minits.toString()+"-"+session.toString());
        fromTime.text  = hour.toString()+":"+minits.toString()+"-"+session.toString();
        update();
        totalTimeCal();

      }else{
        fromTime.text ='';
        update();
      }
    }

  }

  selectToTime(BuildContext context) async {

    int hour=0;
    var minits='';
    var session='';

    picked = (await showTimePicker(initialTime: selectedTime, context: context))!;
    if(picked != null){
      selectedTime = picked;

      //print(selectedTime.period);
      //print(selectedTime.minute);

      Toime=0;
      Tominist=0;
      selectedTime = picked;
      Toime=selectedTime.hour;
      Tominist=selectedTime.minute;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var _date = dateFormat.format(DateTime.now());
      var time1 = (Toime.toString()+":"+Tominist.toString());

      print(DateTime.parse('$_date $time1:00'));
      calToTime = DateTime.parse('$_date $time1:00');
      if(selectedTime.hour>=12){
        //print(selectedTime.hour);

        // hour = int.parse(selectedTime.hour .toString()) - 12;
        // minits = selectedTime.minute .toString();
        hour = selectedTime.hour==12?12:int.parse(selectedTime.hour .toString()) - 12;
        //minits = selectedTime.minute .toString();
        minits = selectedTime.minute .toString().length==1?"0"+selectedTime.minute .toString():selectedTime.minute .toString();
        session = 'PM';
        print(hour.toString()+":"+minits.toString()+"-"+session.toString());
        toTime.text  = hour.toString()+":"+minits.toString()+"-"+session.toString();
        update();
        totalTimeCal();

      }else if (selectedTime.hour<12){
        Toime=0;
        Tominist=0;
        selectedTime = picked;
        Toime=selectedTime.hour;
        Tominist=selectedTime.minute;

        // hour = selectedTime.hour;
        // minits = selectedTime.minute .toString();
        hour = selectedTime.hour==0?12:selectedTime.hour;
        minits = selectedTime.minute .toString().length==1?"0"+selectedTime.minute .toString():selectedTime.minute .toString();
        session = 'AM';
        print(hour.toString()+":"+minits.toString()+"-"+session.toString());
        toTime.text  = hour.toString()+":"+minits.toString()+"-"+session.toString();
        update();
        totalTimeCal();

      }else{
        totalTime.text ='';
        update();
      }
    }

  }

  totalTimeCal(){
    int subTotal=0;
    int subtotalMini=0;
    print(fromtime);
    print(TimeOfDay.now().hour);



    update();
    if(fromtime<TimeOfDay.now().hour&& DateFormat('yyyy-MM-dd').format(DateTime.now()) == fromdate.text){
      log("IF");
      fromTime.text='';
      totalTime.text='';
      toTime.text='';
      Utilities.showDialaogboxWarningMessage(Get.context, "Kindly Choose the above Current Time", 'Notification');

    }
    else if(fromminist<TimeOfDay.now().minute && DateFormat('yyyy-MM-dd').format(DateTime.now()) == fromdate.text
      && (TimeOfDay.now().hour - fromtime)==0){
      log("IF 1");
      fromTime.text='';
      totalTime.text='';
      toTime.text='';
      Utilities.showDialaogboxWarningMessage(Get.context, "Kindly Choose the above Current Minist", 'Notification');

    }

    else if(fromtime>Toime){
      log("ELSE IF");
      toTime.text='';
      totalTime.text='';
      update();
      Utilities.showDialaogboxWarningMessage(Get.context, "To Time", 'Notification');

    }else{
      if(fromtime<Toime){
        subTotal = (Toime - fromtime);
        if (fromminist - Tominist < 0) {
          subtotalMini = ((fromminist - Tominist) * -1);
        } else {
          subtotalMini = (fromminist - Tominist);
        }
        String temp="0";
        // print("hors ${calToTime!.difference(calFromTime!).inHours}");
        // print("moi ${calToTime!.difference(calFromTime!).inMinutes}");
        // print("Cal ${calToTime!.difference(calFromTime!).inMinutes/60}");
        temp=("0."+"${calToTime!.difference(calFromTime!).inMinutes/60}".toString().split('.').last);

        print( (double.parse(temp.toString())*60).roundToDouble().toStringAsFixed(0));

        totalTime.text = "${calToTime!.difference(calFromTime!).inHours}.${(double.parse(temp.toString())*60).roundToDouble().toStringAsFixed(0)}";
        //totalTime.text = (subTotal.toString())+":"+(subtotalMini.toString().length==1?"0"+subtotalMini.toString():subtotalMini.toString());

      }else{
        if(fromminist>Tominist){
          toTime.text='';
          totalTime.text='';
          update();
          Utilities.showDialaogboxWarningMessage(Get.context, "Check Minits", 'Notification');
        }else {
          subTotal = (Toime - fromtime);
          if (fromminist - Tominist < 0) {
            subtotalMini = ((fromminist - Tominist) * -1);
          } else {
            subtotalMini = (fromminist - Tominist);
          }
          String temp="0";
          // print("hors ${calToTime!.difference(calFromTime!).inHours}");
          // print("moi ${calToTime!.difference(calFromTime!).inMinutes}");
          // print("moi ${calToTime!.difference(calFromTime!).inMinutes/60}");
          temp=("0."+"${calToTime!.difference(calFromTime!).inMinutes/60}".toString().split('.').last);

          totalTime.text = "${calToTime!.difference(calFromTime!).inHours}.${(double.parse(temp.toString())*60).roundToDouble().toStringAsFixed(0)}";
          //totalTime.text = subTotal.toString()+"."+(subtotalMini.toString().length==1?"0"+subtotalMini.toString():subtotalMini.toString());
        }
      }

    }

  }

  postSave(formid){
    //print((TotalPermision+(double.parse(totalTime.text.toString()))));
    //print(TotalCount);

    if(sessionUseId.isEmpty){
      Utilities.showDialaogboxWarningMessage(Get.context, "EmpId is not load...", 'Notification');
    }else if(fromdate.text.isEmpty){
      Utilities.showDialaogboxWarningMessage(Get.context, "From Date is not load...", 'Notification');
    } else if(fromTime.text.isEmpty){
      Utilities.showDialaogboxWarningMessage(Get.context, "From Time is not load...", 'Notification');
    }
    else if(toTime.text.isEmpty){
      Utilities.showDialaogboxWarningMessage(Get.context, "To Time is not load...", 'Notification');
    }else if(comments.text.isEmpty){
      Utilities.showDialaogboxWarningMessage(Get.context, "Enter The Remarks", 'Notification');
    }


    else if( double.parse(totalTime.text.toString())>1.00 ){
      Utilities.showDialaogboxWarningMessage(Get.context, "Permision Time Cross the 0.59 ", 'Notification');
    }
    else if(TotalCount>2){
      Utilities.showDialaogboxWarningMessage(Get.context, "Permision Already Booked 2 Time", 'Notification');
    }
    else{
      Allapi.insertPermisionMaster(formid, fromdate.text, fromTime.text, toTime.text, totalTime.text, sessionUseId, '', 'P',comments.text, getDocNo.toString(),true).then((value) => {
        if(value.statusCode==200){
          log(value.body),
          update(),
          Utilities.closeLoader(),
          Utilities.showDialaogboxSavedMessage(Get.context, jsonDecode(value.body)['result'][0]['StatusMesg'].toString(), 'Saved..')
        }

      });
    }
  }
}
