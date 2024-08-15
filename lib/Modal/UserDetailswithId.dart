class UserListModalwithId {
  int? statusCode;
  int? userId;
  String? email;
  String? fName;
  String? lName;
  String? pImage;
  String? vehicleNo;
  String? area;
  String? city;
  int? pincode;
  String? phone;
  int? serviceId;
  String? vehicleName;

  UserListModalwithId(
      {this.statusCode,
        this.userId,
        this.email,
        this.fName,
        this.lName,
        this.pImage,
        this.vehicleNo,
        this.area,
        this.city,
        this.pincode,
        this.phone,
        this.serviceId,
        this.vehicleName});

  UserListModalwithId.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    userId = json['userId'];
    email = json['email'];
    fName = json['fName'];
    lName = json['lName'];
    pImage = json['pImage'];
    vehicleNo = json['vehicleNo'];
    area = json['area'];
    city = json['city'];
    pincode = json['pincode'];
    phone = json['phone'];
    serviceId = json['serviceId'];
    vehicleName = json['vehicleName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['pImage'] = this.pImage;
    data['vehicleNo'] = this.vehicleNo;
    data['area'] = this.area;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['phone'] = this.phone;
    data['serviceId'] = this.serviceId;
    data['vehicleName'] = this.vehicleName;
    return data;
  }
}