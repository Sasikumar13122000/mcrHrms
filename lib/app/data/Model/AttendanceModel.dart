class AttendanceModel {
  int? status;
  List<Result>? result;

  AttendanceModel({this.status, this.result});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
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

  Result(
      {this.dOCNO,
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
        this.aPPROVEDDATE});

  Result.fromJson(Map<String, dynamic> json) {
    dOCNO = json['DOCNO'];
    nAME = json['NAME'];
    eMPID = json['EMPID'];
    dATE = json['DATE'];
    dAY = json['DAY'];
    fROMLATLNG = json['FROMLATLNG'];
    fROMPLACE = json['FROMPLACE'];
    tOLATLNG = json['TOLATLNG'];
    tOPLACE = json['TOPLACE'];
    tOTALDISTANCE = json['TOTALDISTANCE'];
    mONTH = json['MONTH'];
    rEMARKS = json['REMARKS'];
    cREATEDDATE = json['CREATEDDATE'];
    cREATEDBY = json['CREATEDBY'];
    mODIFIEDBY = json['MODIFIEDBY'];
    aPPROVALSTATUS = json['APPROVALSTATUS'];
    aPPROVEDBY = json['APPROVEDBY'];
    lOCATIONTYPE = json['LOCATIONTYPE'];
    lOCATIONNAME = json['LOCATIONNAME'];
    aNOTHERDESCRIPTION = json['ANOTHERDESCRIPTION'];
    fROMTIME = json['FROMTIME'];
    tOTIME = json['TOTIME'];
    aTTENDANCESTATUS = json['ATTENDANCESTATUS'];
    fINALSTATUS = json['FINALSTATUS'];
    aPPROVEDDATE = json['APPROVEDDATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DOCNO'] = this.dOCNO;
    data['NAME'] = this.nAME;
    data['EMPID'] = this.eMPID;
    data['DATE'] = this.dATE;
    data['DAY'] = this.dAY;
    data['FROMLATLNG'] = this.fROMLATLNG;
    data['FROMPLACE'] = this.fROMPLACE;
    data['TOLATLNG'] = this.tOLATLNG;
    data['TOPLACE'] = this.tOPLACE;
    data['TOTALDISTANCE'] = this.tOTALDISTANCE;
    data['MONTH'] = this.mONTH;
    data['REMARKS'] = this.rEMARKS;
    data['CREATEDDATE'] = this.cREATEDDATE;
    data['CREATEDBY'] = this.cREATEDBY;
    data['MODIFIEDBY'] = this.mODIFIEDBY;
    data['APPROVALSTATUS'] = this.aPPROVALSTATUS;
    data['APPROVEDBY'] = this.aPPROVEDBY;
    data['LOCATIONTYPE'] = this.lOCATIONTYPE;
    data['LOCATIONNAME'] = this.lOCATIONNAME;
    data['ANOTHERDESCRIPTION'] = this.aNOTHERDESCRIPTION;
    data['FROMTIME'] = this.fROMTIME;
    data['TOTIME'] = this.tOTIME;
    data['ATTENDANCESTATUS'] = this.aTTENDANCESTATUS;
    data['FINALSTATUS'] = this.fINALSTATUS;
    data['APPROVEDDATE'] = this.aPPROVEDDATE;
    return data;
  }
}
