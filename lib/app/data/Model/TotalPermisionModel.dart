class TotalPermisionModel {
  int? status;
  List<Result>? result;

  TotalPermisionModel({this.status, this.result});

  TotalPermisionModel.fromJson(Map<String, dynamic> json) {
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
  String? takenTime;

  Result({this.takenTime});

  Result.fromJson(Map<String, dynamic> json) {
    takenTime = json['TakenTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TakenTime'] = this.takenTime;
    return data;
  }
}
