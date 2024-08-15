import 'package:flutter/cupertino.dart';


class EmailProvider extends ChangeNotifier{
  late String? defaultEmail;
  late String? defaultfName;
  late String? defaultlName;
  late int? defaultUserId;
  late String? defaultArea;
  late String? defaultCity;
  late int? defaultPincode;
  late String defaultpImage;
  late String? defaultMobile;
  late String? defaultVehicleNo;
  late String? defaultVehicleName;
  EmailProvider({
    this.defaultEmail='',
    this.defaultfName='',
    this.defaultlName='',
    this.defaultArea='',
    this.defaultCity='',
    this.defaultPincode=0,
    this.defaultUserId=0,
    this.defaultpImage='',
    this.defaultMobile='',
    this.defaultVehicleNo='',
    this.defaultVehicleName='',
  });
  void changeEmail({
    required String? newEmail,
    required int? newUserId,
    required String? newFName,
    required String? newLName,
    required String? newArea,
    required String? newCity,
    required int? newPincode,
    required String newPImage,
    required String? newMobile,
    required String? newVehicleNo,
    required String? newVehicleName,

  }) async{
    defaultEmail=newEmail;
    defaultfName=newFName;
    defaultlName=newLName;
    defaultUserId=newUserId;
    defaultArea=newArea;
    defaultCity=newCity;
    defaultPincode=newPincode;
    defaultpImage=newPImage;
    defaultMobile=newMobile;
    defaultVehicleNo=newVehicleNo;
    defaultVehicleName=newVehicleName;
    notifyListeners();
  }
}