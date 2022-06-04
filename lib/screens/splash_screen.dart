import 'package:flutter/material.dart';
import 'package:posterr/screens/home.dart';

import 'package:posterr/components/centered_message.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Posterr',)));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.purple,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.person_rounded, color: Colors.white, size: 70.0),
              Text('Posterr',style: TextStyle(color: Colors.white,
                fontSize: 20.0,
                decoration: TextDecoration.none,)),
              Text('Social Network',style: TextStyle(color: Colors.white, fontSize: 15.0,
                decoration: TextDecoration.none,)),
            ],
          ),
          ),
        );
  }
}