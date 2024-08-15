import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import '../Modal/OrderList.dart';
import '../services/serviceUrls.dart';
import 'OrderConfirmation.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  final ctlSearch=TextEditingController();

  Future<List<OrderListApi>> fetch()async{
    var res =await http.get(Uri.parse("$baseUrl/GetAllServiceWithUser"));
    var data = jsonDecode(res.body);
    return (data as List).map((e)=>OrderListApi.fromJson(e)).toList();
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            List<OrderListApi> l =snapshot.data;
            return Column(
              children: [
                Expanded(
                    child:RefreshIndicator(
                      onRefresh: _refreshData,
                      child: ListView.builder(
                          itemCount: l.length,
                          itemBuilder: (BuildContext context, int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 20,
                                color: const Color.fromRGBO(255, 242, 255,2),
                                shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                                child: ListTile(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>ConfirmationScreen(
                                          userId: l[index].userId,
                                          serviceId: l[index].serviceId,)));
                                  },
                                  leading: const Icon(CupertinoIcons.time,
                                    color: Color.fromRGBO(53, 0, 85, 2),
                                    size: 30,
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('UserId : ${l[index].userId}',
                                        style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      Text('Timings : ${l[index].dateAndTime}',
                                        style: const TextStyle(
                                            color: Color.fromRGBO(53, 0, 85, 2),
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      Text('ServiceId : ${l[index].serviceId}',
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
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
                color: const Color.fromRGBO(53, 0, 85, 2),
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),)
            ]),
          );
        },)
    );
  }
}
