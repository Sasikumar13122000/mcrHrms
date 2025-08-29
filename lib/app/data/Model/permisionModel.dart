class permisionModel {
  int? status;
  List<Result>? result;

  permisionModel({this.status, this.result});

  permisionModel.fromJson(Map<String, dynamic> json) {
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
  String? fROMDATE;
  String? fROMTIME;
  String? tOTIME;
  String? tOTALTIME;
  String? eMPID;
  String? dOCDATE;
  String? sTATUS;
  String? pURPOSEOFVIST;

  Result(
      {this.dOCNO,
        this.fROMDATE,
        this.fROMTIME,
        this.tOTIME,
        this.tOTALTIME,
        this.eMPID,
        this.dOCDATE,
        this.sTATUS,
        this.pURPOSEOFVIST});

  Result.fromJson(Map<String, dynamic> json) {
    dOCNO = json['DOCNO'];
    fROMDATE = json['FROMDATE'];
    fROMTIME = json['FROMTIME'];
    tOTIME = json['TOTIME'];
    tOTALTIME = json['TOTALTIME'];
    eMPID = json['EMPID'];
    dOCDATE = json['DOCDATE'];
    sTATUS = json['STATUS'];
    pURPOSEOFVIST = json['PURPOSEOFVIST'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOCNO'] = this.dOCNO;
    data['FROMDATE'] = this.fROMDATE;
    data['FROMTIME'] = this.fROMTIME;
    data['TOTIME'] = this.tOTIME;
    data['TOTALTIME'] = this.tOTALTIME;
    data['EMPID'] = this.eMPID;
    data['DOCDATE'] = this.dOCDATE;
    data['STATUS'] = this.sTATUS;
    data['PURPOSEOFVIST'] = this.pURPOSEOFVIST;
    return data;
  }
}
