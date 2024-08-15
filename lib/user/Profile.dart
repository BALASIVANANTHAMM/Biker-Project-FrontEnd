import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ProviderClassToChange.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                  backgroundImage: NetworkImage(context.watch<EmailProvider>().defaultpImage),
                ),
                SizedBox(height: 10,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title:Text('${context.watch<EmailProvider>().defaultfName} ${context.watch<EmailProvider>().defaultlName}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title:Text('${context.watch<EmailProvider>().defaultMobile}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(Icons.bike_scooter),
                    title:Text('${context.watch<EmailProvider>().defaultVehicleNo}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title:Text('${context.watch<EmailProvider>().defaultEmail}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(CupertinoIcons.pin),
                    title:Text('${context.watch<EmailProvider>().defaultVehicleName}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(Icons.place),
                    title:Text('${context.watch<EmailProvider>().defaultArea}, ${context.watch<EmailProvider>().defaultCity}'),
                  ),
                ),
                SizedBox(height: 6,),
                Card(
                  elevation: 15,
                  color: const Color.fromRGBO(255, 242, 255,2),
                  shadowColor: const Color.fromRGBO(53, 0, 85, 2),
                  child: ListTile(
                    leading: Icon(CupertinoIcons.pin),
                    title:Text('${context.watch<EmailProvider>().defaultPincode}'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
