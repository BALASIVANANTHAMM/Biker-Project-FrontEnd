import 'dart:async';
import 'dart:convert';

import 'package:bike/Modal/userList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/serviceUrls.dart';
import 'UsersDetails.dart';
class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ctlSearch=TextEditingController();
  bool isLoading =false;
  List<UserListModal> userList = [];
  List<UserListModal> searchedList = [];

  Future<List<UserListModal>> fetch() async{
    var res = await http.get(Uri.parse("$baseUrl/GetTheUserList"));
    var data = await jsonDecode(res.body);
    // setState(() {
    //   userList=data;
    //   searchedList.addAll(userList);
    // });
    return (data as List).map((e)=>UserListModal.fromJson(e)).toList();
  }
  void textChanged(String val) {
    setState(() {
      searchedList.clear();
      if (ctlSearch.text.isEmpty) {
        searchedList.addAll(userList);
      }else{
        for (var item in userList) {
          if (item.userId!.toString().toLowerCase().contains(val.toLowerCase())) {
            searchedList.clear();
            searchedList.add(item);
            print("Data Fetched : $searchedList");
          }
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ctlSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetch(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
             userList = snapshot.data;
             searchedList.addAll(userList);
            return Column(
              children: [
                const SizedBox(height: 7,),
                SizedBox(
                  width: MediaQuery.of(context).size.width-100,
                  child: TextFormField(
                    controller: ctlSearch,
                    onChanged:textChanged,
                    decoration: InputDecoration(
                        hintText: 'Search User..',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {

                            });
                          },
                          icon: const Icon(CupertinoIcons.right_chevron),),
                        prefixIcon: const Icon(CupertinoIcons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)
                        )
                    ),
                  ),
                ),
                searchedList.isNotEmpty==true?
                Expanded(
                  child:
                ListView.builder(
                      itemCount: searchedList.length,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 30,
                            color: const Color.fromRGBO(255, 242, 255,2),
                            shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                            child: ListTile(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>UsersDetails(userId:searchedList[index].userId)));
                              },
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(searchedList[index].pImage!),
                              ),
                              title: Column(
                                children: [
                                  Text('${searchedList[index].fName} ${searchedList[index].lName}'),
                                  Text(searchedList[index].email.toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ):
                const Center(
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
        },

      )
    );
  }
}
