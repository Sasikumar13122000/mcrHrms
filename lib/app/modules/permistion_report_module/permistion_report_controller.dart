import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mrchrms/app/data/Model/permisionModel.dart';
import 'package:mrchrms/app/data/repository/_allAPIList.dart';
import 'package:mrchrms/app/utils/Utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PermistionReportController extends GetxController{

  var sessionUseId  =   '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionType = '';

  late permisionModel rawpermisionModel;
  List<ScreenData> secScreenData=[];

  var fromDate  = TextEditingController();
  var toDate  = TextEditingController();

  final TextEditingController todateShow = TextEditingController();
  final TextEditingController fromdateShow = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    getStringValuesSF();
    super.onInit();
  }


  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sessionUseId  =   prefs.getString('UserID').toString();
    sessionName = prefs.getString('FirstName').toString();
    sessionDeptCode = prefs.getString('DeptCode').toString();
    sessionDeptName = prefs.getString('DeptName').toString();
    sessionType = prefs.getString('Type').toString();
    fromDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    toDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    fromdateShow.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    todateShow.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    print(sessionType);
    getScreenData();
    update();

  }

  getScreenData(){
    secScreenData.clear();
    Allapi.indusAllmaster(3, int.parse(sessionUseId.toString()), sessionUseId.toString(),fromDate.text,toDate.text, true).then((value) => {
      if(value.statusCode==200){
        print(value.body),
        if(jsonDecode(value.body)['status'].toString() == "0"){
          Utilities.closeLoader(),
        }else{
          rawpermisionModel = permisionModel.fromJson(jsonDecode(value.body)),
          for(int i=0;i<rawpermisionModel.result!.length;i++){
            secScreenData.add(
              ScreenData(
                  rawpermisionModel.result![i].dOCNO,
                  rawpermisionModel.result![i].fROMDATE,
                  rawpermisionModel.result![i].fROMTIME,
                  rawpermisionModel.result![i].tOTIME,
                  rawpermisionModel.result![i].tOTALTIME,
                  rawpermisionModel.result![i].eMPID,
                  rawpermisionModel.result![i].dOCDATE,
                  rawpermisionModel.result![i].sTATUS,
                  rawpermisionModel.result![i].pURPOSEOFVIST,
              )
            )
          },
          update(),
          Utilities.closeLoader(),
        }
      }
    });
  }




  selectToDate(BuildContext context,fromid) async {
    var picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null) {
      if (fromid == 1) {
        fromDate.text = DateFormat('yyyy-MM-dd').format(picked);
        fromdateShow.text = DateFormat('dd-MM-yyyy').format(picked);
        update();

      } else if (fromid == 2) {
        toDate.text = DateFormat('yyyy-MM-dd').format(picked);
        todateShow.text = DateFormat('dd-MM-yyyy').format(picked);
        update();
      }

    }
  }
}


class ScreenData {
  int? dOCNO;
  String? fROMDATE;
  String? fROMTIME;
  String? tOTIME;
  String? tOTALTIME;
  String? eMPID;
  String? dOCDATE;
  String? sTATUS;
  String? pURPOSEOFVIST;

  ScreenData(
      this.dOCNO,
      this.fROMDATE,
      this.fROMTIME,
      this.tOTIME,
      this.tOTALTIME,
      this.eMPID,
      this.dOCDATE,
      this.sTATUS,
      this.pURPOSEOFVIST);

}