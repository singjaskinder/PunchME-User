class ServiceHistoryPunchM {
  String uid;
  String userName;
  int times;
  List<String> lapse;

  ServiceHistoryPunchM({this.uid, this.userName, this.times, this.lapse});

  ServiceHistoryPunchM.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['user_name'];
    times = json['times'];
    lapse = json['lapse'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['user_name'] = this.userName;
    data['times'] = this.times;
    data['lapse'] = this.lapse;
    return data;
  }
}

class ServiceHistoryPointM {
  String uid;
  String userName;
  int times;
  List<String> lapse;
  int total;

  ServiceHistoryPointM(
      {this.uid, this.userName, this.times, this.lapse, this.total});

  ServiceHistoryPointM.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    userName = json['user_name'];
    times = json['times'];
    total = json['total'];
    lapse = json['lapse'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['user_name'] = this.userName;
    data['times'] = this.times;
    data['lapse'] = this.lapse;
    data['total'] = this.total;
    return data;
  }
}
