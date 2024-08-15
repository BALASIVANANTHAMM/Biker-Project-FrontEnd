import 'dart:convert';

import 'package:bike/provider/ProviderClassToChange.dart';
import 'package:bike/services/serviceUrls.dart';
import 'package:bike/user/userHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin/adminHome.dart';
import 'package:http/http.dart' as http;

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  RegExp pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  String admin = "admin@gmail.com";
  final _formData = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  
  Future<void> fetch(String email,String password) async{
    try{
      var res=await http.post(
          Uri.parse("$baseUrl/LoginDetailsUser"),
          headers: <String,String>{
            "Content-Type":"application/json; charset=utf-8"
          },
          body: jsonEncode(<String,dynamic>{
            "email": email,
            "password": password
          })
      );
      if(res.statusCode==200){
        final resData = await jsonDecode(res.body);
        if(resData['statusCode']==200){
          if(admin==emailCtrl.text){
            context.read<EmailProvider>()
                .changeEmail(
                newEmail: resData['email'],
                newFName: resData['fName'],
                newLName: resData['lName'],
                newArea: resData['area'],
                newCity: resData['city'],
                newPincode: resData['pincode'],
                newPImage: resData['pImage'],
                newMobile: resData['phone'],
                newVehicleNo: resData['vehicleNo'],
                newUserId: resData['userId'],
                newVehicleName: resData['vehicleName']
                );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AdminHome()));
          }else{
            context.read<EmailProvider>()
                .changeEmail(
                newEmail: resData['email'],
                newFName: resData['fName'],
                newLName: resData['lName'],
                newArea: resData['area'],
                newCity: resData['city'],
                newPincode: resData['pincode'],
                newPImage: resData['pImage'],
                newMobile: resData['phone'],
                newVehicleNo: resData['vehicleNo'],
                newUserId: resData['userId'],
                newVehicleName: resData['vehicleName']
                );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserHome()));
          }
        }
      }else{
        const snackdemo = SnackBar(
          content: Text('Check Your Id and Password'),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
      }catch(e){
          print(e);
          final snackdemo = SnackBar(
          content: Text('Login Error $e'),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-50:MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 242, 255,2),
                  borderRadius: BorderRadius.circular(9)),
              child: Form(
                key: _formData,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Login',
                      style:
                          TextStyle(
                              color: Color.fromRGBO(53, 0, 85, 2),
                              fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 60,
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
                        validator: validatePassword,
                        controller: phoneCtrl,
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
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                    //   child: TextFormField(
                    //     validator: validateName,
                    //     controller: nameCtrl,
                    //     decoration: InputDecoration(
                    //         filled: true,
                    //         fillColor: Colors.white,
                    //         hintText: 'Name..',
                    //         prefixIcon: const Icon(Icons.person),
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(9))),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(136, 15, 178,2)),
                            onPressed: () {
                              if (_formData.currentState!.validate()) {
                                fetch(emailCtrl.text,phoneCtrl.text);
                              }
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty || !email.contains(pattern)) {
      return 'Email Id Not Valid';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty || password.length <= 7) {
      return 'Password Length Not More Than 7';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty || name.length < 5) {
      return 'Name Length Not More Than 5';
    }
    return null;
  }
}
