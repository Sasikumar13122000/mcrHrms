// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mrchrms/app/utils/Utilites.dart';


abstract class Allapi {

  //static String LIVE_URL = "http://47.247.178.234:8445/"; // TEST
  // static String LIVE_URL = "http://47.247.178.234:8442/"; // LIVE
  static String LIVE_URL = "http://20.203.48.172:5055/"; // LIVE
  // static String ImageLIVE_URL = "http://47.247.178.234:8444/"; // ImagePath
  static String ImageLIVE_URL = "http://20.203.48.172:5055/"; // ImagePath


  static Future<http.Response> login(edtUsername,edtPassword,edtDeviceId,isloading) async {

    if(isloading)Utilities.showLoader();
    log('${LIVE_URL}logincheck1');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "Userid": edtUsername,
      "pwd": edtPassword,
      "deviceid": edtDeviceId,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${LIVE_URL}logincheck1'),
          body: jsonEncode(body),
          headers: headers);

      Utilities.closeLoader();

      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }



  static Future<http.Response> postattendance(
      isloading,formid,name,empId,date,day,frmlatlong, fromplace,tolatlng,toplace,totaldistance,month,remarks,
      createby,modifiedBy,approvestatus,locationtype,locationnanme,description,fromtime,totime,finalstatus,
      maxDocNo
      ) async {

    log('${LIVE_URL}InSalesInsertAttendance');
    if(isloading)Utilities.showLoader();
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FormID": formid,
      "Name": name,
      "EmpId": empId,
      "Date": date,
      "Day": "",
      "FromLatLng":frmlatlong,
      "FromPlace": fromplace,
      "ToLatLng": tolatlng,
      "ToPlace": toplace,
      "TotalDistance": totaldistance,
      "Month": month,
      "Remarks": remarks,
      "CreatedBy": createby,
      "ModifiedBy": modifiedBy,
      "ApprovalStatus": approvestatus,
      "ApprovedBy": "",
      "LocationType": locationtype,
      "LocationName": locationnanme,
      "Discription": description,
      "FromTime": fromtime ,
      "ToTime": totime,
      "FinalStatus":finalstatus,
      "MaxDocNo":maxDocNo,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse('${LIVE_URL}InSalesInsertAttendance'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }



  static Future<http.Response> insertPermisionMaster(formid,fromdate,fromTime,totime,totalTime,empId,docdate,
      status,purposeofvist,docNo, isloading) async {

    if(isloading)Utilities.showLoader();
    log(LIVE_URL + 'insetPermisionmaster');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId": formid,
      "Fromdate": fromdate,
      "FromTime": fromTime,
      "ToTime": totime,
      "TotalTime": totalTime,
      "EmpId": empId,
      "DocDate": docdate,
      "Status": status,
      "Purposeofvist": purposeofvist,
      "DocNo": docNo,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(LIVE_URL + 'insetPermisionmaster'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }
  static Future<http.Response> getApprovelList(formid,userid,docdate,status,DocNo,isloading) async {

    if(isloading)Utilities.showLoader();
    log(LIVE_URL + 'getPermisionMaster');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId": formid,
      "UserId": userid,
      "DocDate": docdate,
      "Status": status,
      "DocNo":DocNo
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(LIVE_URL + 'getPermisionMaster'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }


  static Future<http.Response> insertOnDutyMaster(formid,onDutyType,fromDate,toDate,fromLocation,toLocation,fromTime,toTime,
      empId,status,docDate,docNo,purpose,isloading) async {

    if(isloading)Utilities.showLoader();
    log(LIVE_URL + 'insetOnDutymaster');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FromId": formid,
      "OnDutyType": onDutyType,
      "FromDate": fromDate,
      "ToDate": toDate,
      "FromLocation": fromLocation,
      "ToLocation": toLocation,
      "FromTIme": fromTime,
      "ToTime": toTime,
      "EmpId": empId,
      "Status": status,
      "DocDate": docDate,
      "DocNo": docNo,
      "Purpose":purpose
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(LIVE_URL + 'insetOnDutymaster'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }



  static Future<http.Response> indusAllmaster(formid,userId,docNo,fromDate,toDate,isloading) async {

    if(isloading)Utilities.showLoader();
    log(LIVE_URL + 'indusAllmaster');
    var headers = {"Content-Type": "application/json"};
    var body = {
      "FormID": formid,
      "UserID": userId,
      "DocNo": docNo,
      "fromDate": fromDate,
      "toDate": toDate,
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(LIVE_URL + 'indusAllmaster'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }

  static Future<http.Response> getLeaveType(formid,docNo,status,type,leadno,isloading) async {

    if(isloading)Utilities.showLoader();
    log(LIVE_URL + 'getallmaster');
    var headers = {"Content-Type": "application/json"};
    var body = {

      "FormID": formid,
      "DocNo": docNo,
      "Status": status,
      "Type": type,
      "Leadno": leadno
    };
    log(jsonEncode(body));
    try {
      final response = await http.post(
          Uri.parse(LIVE_URL + 'getallmaster'),
          body: jsonEncode(body),
          headers: headers);
      return response;
    } on SocketException {
      throw Exception('Internet is down');
    }
  }


  // static Future<http.Response> insertLeaveMaster(formid,empId,leaveType,leaveCode,fromDate,todate,noOfDays,comments,status,docNo,isloading) async {
  //
  //   if(isloading)Utilities.showLoader();
  //   log(LIVE_URL + 'insetLeaveqmaster');
  //   var headers = {"Content-Type": "application/json"};
  //   var body = {
  //     "FromId": formid,
  //     "EmpId": empId,
  //     "LeaveType": leaveType,
  //     "LeaveCode": leaveCode,
  //     "FromDate": fromDate,
  //     "Todate": todate,
  //     "NoOfDays": noOfDays,
  //     "Comments": comments,
  //     "Status": status,
  //     "DocNo": docNo,
  //   };
  //   log(jsonEncode(body));
  //   try {
  //     final response = await http.post(
  //         Uri.parse(LIVE_URL + 'insetLeaveqmaster'),
  //         body: jsonEncode(body),
  //         headers: headers);
  //     return response;
  //   } on SocketException {
  //     throw Exception('Internet is down');
  //   }
  // }


  // In your Allapi class
  static Future<http.Response> insertLeaveMaster(
      int fromId,
      String empId,
      String leaveType,
      String leaveCode,
      String fromDate,
      String toDate,
      String noOfDays,
      String comments,
      String status,
      String docNo,
      bool showLoader,
      ) async {
    final url = Uri.parse('http://20.203.48.172:5055/indusAllmaster');

    final body = {
      'FromId': fromId.toString(),
      'EmpId': empId,
      'LeaveType': leaveType,
      'LeaveCode': leaveCode,
      'FromDate': fromDate,
      'Todate': toDate,
      'NoOfDays': noOfDays,
      'Comments': comments,
      'Status': status,
      'DocNo': docNo,
    };

    log('Sending to API: $body');

    return await http.post(
      url,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }

}