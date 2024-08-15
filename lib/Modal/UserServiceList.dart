class UserServiceList {
  int? statusCode;
  int? serviceId;
  int? userId;
  String? timings;
  String? dateAndTime;

  UserServiceList(
      {this.statusCode,
        this.serviceId,
        this.userId,
        this.timings,
        this.dateAndTime});

  UserServiceList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    serviceId = json['serviceId'];
    userId = json['userId'];
    timings = json['timings'];
    dateAndTime = json['dateAndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['serviceId'] = this.serviceId;
    data['userId'] = this.userId;
    data['timings'] = this.timings;
    data['dateAndTime'] = this.dateAndTime;
    return data;
  }
}