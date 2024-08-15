import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Modal/UserDetailswithId.dart';
import 'package:http/http.dart'as http;

import '../services/serviceUrls.dart';

class UsersDetails extends StatefulWidget {
  final int? userId;
  const UsersDetails({super.key,required this.userId});

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {

  Future<UserListModalwithId> fetch()async{
    var res = await http.get(Uri.parse("$baseUrl/GetUserById?userId=${widget.userId}"));
    return UserListModalwithId.fromJson(jsonDecode(res.body));
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
          title: const Text('User Details',style: TextStyle(
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: const Color.fromRGBO(255, 242, 255,2),
                          backgroundImage: NetworkImage(snapshot.data!.pImage!),
                        ),
                        SizedBox(height: 10,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title:Text('${snapshot.data!.fName} ${snapshot.data!.lName}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(Icons.phone),
                            title:Text('${snapshot.data!.phone}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(Icons.bike_scooter),
                            title:Text('${snapshot.data!.vehicleNo}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(Icons.email),
                            title:Text('${snapshot.data!.email}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(Icons.place),
                            title:Text('${snapshot.data!.area}, ${snapshot.data!.city}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(CupertinoIcons.pin),
                            title:Text('${snapshot.data!.pincode}'),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Card(
                          elevation: 15,
                          color: const Color.fromRGBO(255, 242, 255,2),
                          shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                          child: ListTile(
                            leading: Icon(CupertinoIcons.pin),
                            title:Text('${snapshot.data!.vehicleName}'),
                          ),
                        ),
                      ],
                    ),
                  ),
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
