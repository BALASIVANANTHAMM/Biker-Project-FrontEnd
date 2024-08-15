import 'dart:convert';

import 'package:bike/provider/ProviderClassToChange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Modal/ConfirmUserId.dart';
import 'package:http/http.dart'as http;

import '../services/serviceUrls.dart';

class StatusConfirm extends StatefulWidget {
  const StatusConfirm({super.key});

  @override
  State<StatusConfirm> createState() => _StatusConfirmState();
}

class _StatusConfirmState extends State<StatusConfirm> {

  Future<List<ConfirmUserId>> fetch()async{
    var res = await http.get(Uri.parse("$baseUrl/GetConfirmUserId?userId=${context.watch<EmailProvider>().defaultUserId}"));
    var data = jsonDecode(res.body);
    return (data as List).map((e)=>ConfirmUserId.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<ConfirmUserId> l = snapshot.data;
            return ListView.builder(
                itemCount: l.length,
                itemBuilder: (BuildContext context,int index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 25,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Text(
                         'S:${l[index].serviceId}',style: const TextStyle(
                        color: Color.fromRGBO(53, 0, 85, 2),
                        fontWeight: FontWeight.bold
                    ),),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l[index].status.toString(),style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: l[index].status=='Scheduled'?Colors.green:Colors.red
                        ),),
                        Text(l[index].message.toString(),style: const TextStyle(
                          color: Color.fromRGBO(53, 0, 85, 2),
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    trailing: Icon(Icons.circle,
                        color: l[index].status=='Scheduled'?Colors.green:Colors.red
                    )
                  ),
                ),
              );
            });
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
                      color: Color.fromRGBO(53, 0, 85, 2),
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),)
                ]),
          );
        },)
    );
  }
}
