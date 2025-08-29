import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mrchrms/app/data/Model/OndutyModel.dart';
import 'package:mrchrms/app/data/repository/_allAPIList.dart';
import 'package:mrchrms/app/utils/Utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OndutyReportController extends GetxController{


  var sessionUseId  =   '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionType = '';


  late OndutyModel rawOndutyModel;

  List<ScreenData> secScreenData=[];

  var fromDate  = TextEditingController();
  var toDate  = TextEditingController();

  final TextEditingController todateShow = TextEditingController();
  final TextEditingController fromdateShow = TextEditingController();


  @override
  void onInit() {
    getStringValuesSF();
    update();
    // TODO: implement onInit
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
    Allapi.indusAllmaster(4, int.parse(sessionUseId.toString()), sessionUseId.toString(),fromDate.text,toDate.text, true).then((value) => {
      if(value.statusCode==200){
        print(value.body),
        if(jsonDecode(value.body)['status'].toString() == "0"){
          Utilities.closeLoader(),
        }else{
          rawOndutyModel = OndutyModel.fromJson(jsonDecode(value.body)),
          for(int i=0;i<rawOndutyModel.result!.length;i++){
            secScreenData.add(
                ScreenData(
                    rawOndutyModel.result![i].dOCNO,
                    rawOndutyModel.result![i].oNDUTYTYPE,
                    rawOndutyModel.result![i].fROMDATE,
                    rawOndutyModel.result![i].tODATE,
                    rawOndutyModel.result![i].fROMLOCATION,
                    rawOndutyModel.result![i]. tOLOCATION,
                    rawOndutyModel.result![i].fROMTIME,
                    rawOndutyModel.result![i].tOTIME,
                    rawOndutyModel.result![i].eMPID,
                    rawOndutyModel.result![i].sTATUS,
                    rawOndutyModel.result![i].dOCDATE,
                    rawOndutyModel.result![i].pURPOSE)
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
  String? oNDUTYTYPE;
  String? fROMDATE;
  String? tODATE;
  String? fROMLOCATION;
  String? tOLOCATION;
  String? fROMTIME;
  String? tOTIME;
  String? eMPID;
  String? sTATUS;
  String? dOCDATE;
  String? pURPOSE;
  ScreenData(this.dOCNO,
      this.oNDUTYTYPE,
      this.fROMDATE,
      this.tODATE,
      this.fROMLOCATION,
      this.tOLOCATION,
      this.fROMTIME,
      this.tOTIME,
      this.eMPID,
      this.sTATUS,
      this.dOCDATE,
      this.pURPOSE);

}
