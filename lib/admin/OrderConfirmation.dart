import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Modal/ServiceDetailsIds.dart';
import 'package:http/http.dart'as http;

import '../services/serviceUrls.dart';

class ConfirmationScreen extends StatefulWidget {
  final int? userId;
  final int? serviceId;
  const ConfirmationScreen({
    super.key,
    required this.userId,
    required this.serviceId
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {

  final msgCtl = TextEditingController();
  List<String> items = ['Scheduled','Not Scheduled'];
  String? dropdownValue ='Scheduled';

  Future<void> schedule(
      int? uId,int? sId,String? status,String? msg
      )async{
    var res = await http.post(
      Uri.parse("$baseUrl/AddConfirmation"),
      headers: <String,String>{
        "Content-Type":"application/json; charset=utf-8"
      },
      body: jsonEncode(<String,dynamic>{
        "userId":uId,
        "serviceId":sId,
        "status":status,
        "message":msg
      })
    );
    if(res.statusCode==200){
      final resData = jsonDecode(res.body);
      if(resData['statusCode']==200){
        print('Successfully Added');
      }
    }
  }

  Future<ServiceIds> fetch()async{
    var res = await http.get(Uri.parse("$baseUrl/GetServiceWithIds?userId=${widget.userId}&serviceId=${widget.serviceId}"));
    return ServiceIds.fromJson(jsonDecode(res.body));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
          ),
          backgroundColor: const Color.fromRGBO(53, 0, 85, 2),
          toolbarHeight: 70,
          title: const Text('Send Confirmations',style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),),
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.chevron_left_outlined,color: Colors.white,),),),
        body: FutureBuilder(
          future: fetch(),
          builder: (BuildContext context, snapshot) {
            if(snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-50:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 242, 255,2),
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Confirm Request',
                            style:
                            TextStyle(
                                color: Color.fromRGBO(53, 0, 85, 2),
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('User Id : ${widget.userId}',
                                style:
                                const TextStyle(
                                    color: Color.fromRGBO(53, 0, 85, 2),
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text('Service Id : ${widget.serviceId}',
                                style:
                                const TextStyle(
                                    color: Color.fromRGBO(53, 0, 85, 2),
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          DropdownButton<String>(
                            dropdownColor: const Color.fromRGBO(255, 242, 255,2),
                            focusColor: const Color.fromRGBO(53, 0, 85, 2),
                            elevation: 9,
                            borderRadius: BorderRadius.circular(12),
                            value: dropdownValue,
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items:items
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width>105?MediaQuery.of(context).size.width-100:MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: msgCtl,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Message..',
                                  prefixIcon: const Icon(Icons.message_outlined,
                                  color: Color.fromRGBO(53, 0, 85, 2),),
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
                                  onPressed: () {
                                    String? txt = msgCtl.text;
                                    schedule(widget.userId,widget.serviceId,dropdownValue,txt);
                                    setState(() {
                                      msgCtl.clear();
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Confirm',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    CupertinoActivityIndicator(
                      radius: 20,
                      animating: true,
                    ),
                    SizedBox(height: 12,),
                    Text('Loading...',style: TextStyle(
                        color:  Color.fromRGBO(53, 0, 85, 2),
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),)
                  ]),
            );
          },),
      ),
    );
  }
}
