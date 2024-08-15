import 'dart:convert';

import 'package:bike/provider/ProviderClassToChange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import '../Modal/UserServiceList.dart';
import '../services/serviceUrls.dart';

class ScheduledList extends StatefulWidget {
  const ScheduledList({super.key});

  @override
  State<ScheduledList> createState() => _ScheduledListState();
}

class _ScheduledListState extends State<ScheduledList> {
  List sList=[
    '10','12','1','3'
  ];

  Future<List<UserServiceList>> fetch()async{
    var res = await http.get(Uri.parse("$baseUrl/GetServiceWithUser?userId=${context.watch<EmailProvider>().defaultUserId}"));
    var data = jsonDecode(res.body);
    return (data as List).map((e)=>UserServiceList.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<UserServiceList> l = snapshot.data;
            return Column(
              children: [
                Expanded(
                    child:ListView.builder(
                        itemCount: l.length,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 25,
                              color: const Color.fromRGBO(255, 242, 255,2),
                              shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                              child: ListTile(
                                leading: const Icon(Icons.delivery_dining_outlined),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Time : ${l[index].dateAndTime}',style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                    ),),
                                  ],
                                ),
                                trailing: Text('${l[index].userId}',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          );
                        })
                )
              ],
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
