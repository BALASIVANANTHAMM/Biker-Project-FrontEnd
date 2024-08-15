import 'dart:convert';

import 'package:bike/services/serviceUrls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formData = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final fNameCtrl = TextEditingController();
  final lNameCtrl = TextEditingController();
  final pImageCtrl = TextEditingController();
  final vehicleNoCtrl = TextEditingController();
  final areaCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final vehicleNameCtrl = TextEditingController();
  final cityCtrl = TextEditingController();
  final pincodeCtrl = TextEditingController();
  final mobileNoCtrl = TextEditingController();
  RegExp pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  
  Future<void> fetch(
      String email,
      String password,
      String fName,
      String lName,
      String pImage,
      String vehicleNo,
      String area,
      String city,
      int pincode,
      String mobileNo,
      String vehicleName,
      )async{
    var res = await http.post(
      Uri.parse("$baseUrl/AddUsersDetails"),
      headers: <String,String>{
        "Content-Type":"application/json; charset=utf-8"
      },
      body: jsonEncode(<String,dynamic>{
          "email": email,
          "password": password,
          "fName": fName,
          "lName": lName,
          "pImage": pImage,
          "vehicleNo": vehicleNo,
          "area": area,
          "city": city,
          "pincode": pincode,
          "phone": mobileNo,
          "vehicleName": vehicleName
      })
    );
    if(res.statusCode==200){
      final resData=jsonDecode(res.body);
      if(resData['statusCode']==200){
        showDialog(
            barrierColor: const Color.fromRGBO(255, 242, 255,2),
            context: context,
            builder: (BuildContext context){
              return const AlertDialog(
                title: Text("Success"),
                content: Text("Saved successfully"),
              );
        });
        print("Success");
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    pImageCtrl.text='https://www.pngall.com/wp-content/uploads/5/Profile-PNG-Free-Download.png';
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-50:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 242, 255,2),
              borderRadius: BorderRadius.circular(9)),
          child: Form(
            key: _formData,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Create Users',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/3,
                        child: TextFormField(
                          //validator: validateEmail,
                          controller: fNameCtrl,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'FirstName..',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/3,
                        child: TextFormField(
                          //validator: validateEmail,
                          controller: lNameCtrl,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'LastName..',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(9))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: validateEmail,
                      controller: emailCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email..',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      readOnly: true,
                      //validator: validateEmail,
                      controller: pImageCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Profile Image..',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: vehicleNoCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Vehicle No..',
                          prefixIcon: const Icon(Icons.numbers),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: areaCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Area..',
                          prefixIcon: const Icon(Icons.area_chart_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: cityCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'City..',
                          prefixIcon: const Icon(Icons.location_city),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: pincodeCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Pincode..',
                          prefixIcon: const Icon(Icons.pin),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: mobileNoCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Mobile No..',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: vehicleNameCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Vehicle Name..',
                          prefixIcon: const Icon(Icons.electric_bike),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    child: TextFormField(
                      //validator: validatePassword,
                      controller: passCtrl,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password..',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(136, 15, 178,2),),
                          onPressed: () {
                            if (_formData.currentState!.validate()) {
                              int a=int.parse(pincodeCtrl.text);
                              fetch(
                                  emailCtrl.text,
                                  passCtrl.text,
                                  fNameCtrl.text,
                                  lNameCtrl.text,
                                  pImageCtrl.text,
                                  vehicleNoCtrl.text,
                                  areaCtrl.text,
                                  cityCtrl.text,
                                  a,
                                  mobileNoCtrl.text,
                                  vehicleNameCtrl.text
                              );
                              setState(() {
                                emailCtrl.clear();
                                passCtrl.clear();
                                fNameCtrl.clear();
                                lNameCtrl.clear();
                                //pImageCtrl.clear();
                                vehicleNoCtrl.clear();
                                areaCtrl.clear();
                                cityCtrl.clear();
                                pincodeCtrl.clear();
                                mobileNoCtrl.clear();
                                vehicleNameCtrl.clear();
                              });
                            }
                          },
                          child: const Text(
                            'Create User',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
                  const SizedBox(height: 39,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains(pattern)) {
      return 'Email Id Not Valid';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password Not Valid';
    }
    return null;
  }
}
