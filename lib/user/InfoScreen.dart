import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const ListTile(
              leading: Icon(Icons.speaker_notes_outlined,
                color: Color.fromRGBO(22,0,38,2),
              ),
              title: const Text('Terms of Service',style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(22,0,38,2),
                  fontWeight: FontWeight.bold
              ),),
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.lock_shield,
                color: Color.fromRGBO(22,0,38,2),
              ),
              title: Text('Privacy Policy',style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(22,0,38,2),
                  fontWeight: FontWeight.bold
              ),),
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.exclamationmark_triangle),
              title: const Text('About App',style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(22,0,38,2),
                  fontWeight: FontWeight.bold
              ),),
              onTap: (){
                showDialog(
                  barrierColor: const Color.fromRGBO(255, 242, 255,2),
                    context: context,
                    builder: (BuildContext context){
                      return const AboutDialog(
                        applicationIcon: FlutterLogo(),
                        applicationName: 'Biker.com App',
                        applicationVersion: '1.0.0',
                        applicationLegalese: '©2024 Biker.com',
                      );
                    });
              },
            ),
            const ListTile(
              leading: Icon(CupertinoIcons.exclamationmark_octagon,
                color: Color.fromRGBO(22,0,38,2),
              ),
              title: Text('Version 1.0.0',style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(22,0,38,2),
                  fontWeight: FontWeight.bold
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
