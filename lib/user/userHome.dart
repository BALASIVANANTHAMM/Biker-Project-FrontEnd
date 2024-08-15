import 'package:bike/provider/ProviderClassToChange.dart';
import 'package:bike/user/InfoScreen.dart';
import 'package:bike/user/userAddService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Profile.dart';
import 'ScheduledList.dart';
import 'StatusConfirmation.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> with TickerProviderStateMixin {
  int _selectedIndex =0;
  static const List<Widget> _widgetOptions = <Widget>[
    Profile(),
    UserAddService(),
    StatusConfirm(),
    ScheduledList(),
    InfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25))
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(53, 0, 85, 2),
          toolbarHeight: 70,
          title: Text('Welcome ${context.watch<EmailProvider>().defaultfName}',style: const TextStyle(
              fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        ),
        body: _widgetOptions[_selectedIndex],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(136, 15, 178,2),
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color:Color.fromRGBO(136, 15, 178,2),),
                  accountName: Text(
                    '${context.watch<EmailProvider>().defaultfName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text('${context.watch<EmailProvider>().defaultEmail}'),
                  currentAccountPictureSize: const Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(context.watch<EmailProvider>().defaultpImage),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.person),
                title: const Text(' My Profile '),
                selected: _selectedIndex == 0,
                selectedColor: const Color.fromRGBO(53, 0, 85, 2),
                selectedTileColor: const Color.fromRGBO(255, 242, 255,2),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.add_circled),
                title: const Text(' Book Time '),
                selected: _selectedIndex == 1,
                selectedColor: const Color.fromRGBO(53, 0, 85, 2),
                selectedTileColor: const Color.fromRGBO(255, 242, 255,2),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.list_bullet_below_rectangle),
                title: const Text(' Status '),
                selected: _selectedIndex == 2,
                selectedColor: const Color.fromRGBO(53, 0, 85, 2),
                selectedTileColor: const Color.fromRGBO(255, 242, 255,2),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.list_bullet_below_rectangle),
                title: const Text(' Scheduled List '),
                selected: _selectedIndex == 3,
                selectedColor: const Color.fromRGBO(53, 0, 85, 2),
                selectedTileColor: const Color.fromRGBO(255, 242, 255,2),
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.exclamationmark_shield),
                title: const Text('App Info'),
                selected: _selectedIndex == 4,
                selectedColor: const Color.fromRGBO(53, 0, 85, 2),
                selectedTileColor: const Color.fromRGBO(255, 242, 255,2),
                onTap: () {
                  _onItemTapped(4);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
