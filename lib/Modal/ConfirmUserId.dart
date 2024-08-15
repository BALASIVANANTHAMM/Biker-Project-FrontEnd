class ConfirmUserId {
  int? statusCode;
  int? scheduleId;
  int? userId;
  int? serviceId;
  String? status;
  String? message;

  ConfirmUserId(
      {this.statusCode,
        this.scheduleId,
        this.userId,
        this.serviceId,
        this.status,
        this.message});

  ConfirmUserId.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    scheduleId = json['scheduleId'];
    userId = json['userId'];
    serviceId = json['serviceId'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['scheduleId'] = this.scheduleId;
    data['userId'] = this.userId;
    data['serviceId'] = this.serviceId;
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}