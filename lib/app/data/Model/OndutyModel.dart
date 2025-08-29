class OndutyModel {
  int? status;
  List<Result>? result;

  OndutyModel({this.status, this.result});

  OndutyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
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

  Result(
      {this.dOCNO,
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
        this.pURPOSE});

  Result.fromJson(Map<String, dynamic> json) {
    dOCNO = json['DOCNO'];
    oNDUTYTYPE = json['ONDUTYTYPE'];
    fROMDATE = json['FROMDATE'];
    tODATE = json['TODATE'];
    fROMLOCATION = json['FROMLOCATION'];
    tOLOCATION = json['TOLOCATION'];
    fROMTIME = json['FROMTIME'];
    tOTIME = json['TOTIME'];
    eMPID = json['EMPID'];
    sTATUS = json['STATUS'];
    dOCDATE = json['DOCDATE'];
    pURPOSE = json['PURPOSE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOCNO'] = this.dOCNO;
    data['ONDUTYTYPE'] = this.oNDUTYTYPE;
    data['FROMDATE'] = this.fROMDATE;
    data['TODATE'] = this.tODATE;
    data['FROMLOCATION'] = this.fROMLOCATION;
    data['TOLOCATION'] = this.tOLOCATION;
    data['FROMTIME'] = this.fROMTIME;
    data['TOTIME'] = this.tOTIME;
    data['EMPID'] = this.eMPID;
    data['STATUS'] = this.sTATUS;
    data['DOCDATE'] = this.dOCDATE;
    data['PURPOSE'] = this.pURPOSE;
    return data;
  }
}
