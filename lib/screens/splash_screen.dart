import 'package:flutter/material.dart';
import 'package:posterr/screens/home.dart';

import '../components/centered_message.dart';

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
        child: CenteredMessage(
          'Posterr - Social Network',
          icon: Icons.people_outline_rounded,
        );
        )
    );
  }
}