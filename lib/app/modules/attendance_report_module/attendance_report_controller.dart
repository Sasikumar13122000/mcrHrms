import 'dart:convert';

import 'package:get/get.dart';
import 'package:mrchrms/app/data/Model/AttendanceModel.dart';
import 'package:mrchrms/app/data/repository/_allAPIList.dart';
import 'package:mrchrms/app/utils/Utilites.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AttendanceReportController extends GetxController{

  var sessionUseId  =   '';
  var sessionName = '';
  var sessionDeptCode = '';
  var sessionDeptName = '';
  var sessionType = '';

  late AttendanceModel rawAttendanceModel;

  List<ScreenData> secScreenData=[];

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
    print(sessionType);
    getScreenData();
    update();

  }

  getScreenData(){
    Allapi.indusAllmaster(2, int.parse(sessionUseId.toString()), sessionUseId.toString(),'','', true).then((value) => {
      if(value.statusCode==200){
        print(value.body),
        if(jsonDecode(value.body)['status'].toString() == "0"){
          Utilities.closeLoader(),
        }else{
          rawAttendanceModel = AttendanceModel.fromJson(jsonDecode(value.body)),
          for(int i=0;i<rawAttendanceModel.result!.length;i++){
          secScreenData.add(
              ScreenData(
                  rawAttendanceModel.result![i].dOCNO,
                  rawAttendanceModel.result![i].nAME,
                  rawAttendanceModel.result![i].eMPID,
                  rawAttendanceModel.result![i].dATE,
                  rawAttendanceModel.result![i].dAY,
                  rawAttendanceModel.result![i].fROMLATLNG,
                  rawAttendanceModel.result![i].fROMPLACE,
                  rawAttendanceModel.result![i].tOLATLNG,
                  rawAttendanceModel.result![i].tOPLACE,
                  rawAttendanceModel.result![i].tOTALDISTANCE,
                  rawAttendanceModel.result![i].mONTH,
                  rawAttendanceModel.result![i].rEMARKS,
                  rawAttendanceModel.result![i].cREATEDDATE,
                  rawAttendanceModel.result![i].cREATEDBY,
                  rawAttendanceModel.result![i].mODIFIEDBY,
                  rawAttendanceModel.result![i].aPPROVALSTATUS,
                  rawAttendanceModel.result![i].aPPROVEDBY,
                  rawAttendanceModel.result![i].lOCATIONTYPE,
                  rawAttendanceModel.result![i].lOCATIONNAME,
                  rawAttendanceModel.result![i].aNOTHERDESCRIPTION,
                  rawAttendanceModel.result![i].fROMTIME,
                  rawAttendanceModel.result![i].tOTIME,
                  rawAttendanceModel.result![i].aTTENDANCESTATUS,
                  rawAttendanceModel.result![i].fINALSTATUS,
                  rawAttendanceModel.result![i].aPPROVEDDATE,
              ),
          )
        },
          update(),
          Utilities.closeLoader(),
        }
      }
    });
  }

}


class ScreenData {
  int? dOCNO;
  String? nAME;
  String? eMPID;
  String? dATE;
  String? dAY;
  String? fROMLATLNG;
  String? fROMPLACE;
  String? tOLATLNG;
  String? tOPLACE;
  String? tOTALDISTANCE;
  int? mONTH;
  String? rEMARKS;
  String? cREATEDDATE;
  String? cREATEDBY;
  String? mODIFIEDBY;
  int? aPPROVALSTATUS;
  String? aPPROVEDBY;
  String? lOCATIONTYPE;
  String? lOCATIONNAME;
  String? aNOTHERDESCRIPTION;
  String? fROMTIME;
  String? tOTIME;
  String? aTTENDANCESTATUS;
  String? fINALSTATUS;
  String? aPPROVEDDATE;

  ScreenData(
      this.dOCNO,
        this.nAME,
        this.eMPID,
        this.dATE,
        this.dAY,
        this.fROMLATLNG,
        this.fROMPLACE,
        this.tOLATLNG,
        this.tOPLACE,
        this.tOTALDISTANCE,
        this.mONTH,
        this.rEMARKS,
        this.cREATEDDATE,
        this.cREATEDBY,
        this.mODIFIEDBY,
        this.aPPROVALSTATUS,
        this.aPPROVEDBY,
        this.lOCATIONTYPE,
        this.lOCATIONNAME,
        this.aNOTHERDESCRIPTION,
        this.fROMTIME,
        this.tOTIME,
        this.aTTENDANCESTATUS,
        this.fINALSTATUS,
        this.aPPROVEDDATE);

}
