import 'package:flutter/material.dart';
import 'package:posterr/screens/home.dart';

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
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            child: Text('Posterr - The social network'),
          ),
        )
    );
  }
}