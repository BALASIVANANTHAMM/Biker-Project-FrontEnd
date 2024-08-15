import 'dart:convert';
import 'package:bike/provider/ProviderClassToChange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/serviceUrls.dart';

class UserAddService extends StatefulWidget {
  const UserAddService({super.key});

  @override
  State<UserAddService> createState() => _UserAddServiceState();
}

class _UserAddServiceState extends State<UserAddService> {
  bool visible = false;
  bool buttonVisible = false;
  String? success;
  final _formData = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final vehicleNameCtrl = TextEditingController();
  final vehicleNoCtrl = TextEditingController();
  String? selectedDateTime;

  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');

  Future<void> fetch(int userId,String Timings)async{
    var res = await http.post(
        Uri.parse("$baseUrl/AddServiceTimings"),
        headers: <String,String>{
          "Content-Type":"application/json; charset=utf-8"
        },
        body: jsonEncode(<String,dynamic>{
          "userId":userId,
          "timings": "2024-07-30T14:26:50.399Z",
          "dateAndTime":Timings
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
        print('Added Successfully');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nameCtrl.text = '${context.watch<EmailProvider>().defaultfName!} ${context.watch<EmailProvider>().defaultlName!}';
    vehicleNoCtrl.text = context.watch<EmailProvider>().defaultVehicleNo!;
    vehicleNameCtrl.text=context.watch<EmailProvider>().defaultUserId!.toString();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(136, 15, 178,2),
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: () {
          setState(() {
            visible=true;
          });
        },
      ),
      body: visible==false
      ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Please Press To Add Your Service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(136, 15, 178,2),
                  fontSize: 18
              ),)
            ],
          ))
      :Center(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
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
                  'Add Service',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                  child: TextFormField(
                    // validator: validateEmail,
                    controller: nameCtrl,
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Your Name..',
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
                    // validator: validatePassword,
                    readOnly: true,
                    controller: vehicleNameCtrl,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Vehicle Name..',
                        prefixIcon: const Icon(Icons.bike_scooter),
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
                    // validator: validatePassword,
                    controller: vehicleNoCtrl,
                    readOnly: true,
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
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(136, 15, 178,2)),
                      onPressed: (){
                    dateTimePickerWidget(context);
                    setState(() {
                      buttonVisible=true;
                    });
                  }, child: const Text('Pick Your Timings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),)),
                ),
                SizedBox(height: 30,),

                Visibility(
                  visible: buttonVisible,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(136, 15, 178,2)),
                          onPressed: () {
                            int a = int.parse(vehicleNameCtrl.text);
                            fetch(a, selectedDateTime!);
                            setState(() {
                              visible=false;
                            });
                          },
                          child: const Text(
                            'Book Service',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))),
                )
              ],
            ),
          ),
        ),
      )

    );
  }
  Future<void> dateTimePickerWidget(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2040),
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          // Handle the selected date and time here.
          if (selectedTime != null) {
            DateTime t = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour, selectedTime.minute);
            selectedDateTime=formatter.format(t);
            selectedDateTime='${selectedDateTime} ${selectedTime.period.toString().split('.')[1]}';
            print(selectedDateTime);
          }else{
            setState(() {
              buttonVisible=false;
            });
          }
        });
      }else{
        setState(() {
          buttonVisible=false;
        });
      }
    });
  }
}
