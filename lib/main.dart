import 'package:flutter/material.dart';
import 'package:posterr/screens/splash_screen.dart';
import 'dao/posterr_posts_class.dart';
import 'dao/posterr_users_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Create and populate initial database for local execution;
    final posterrUsers objposterrUsers = posterrUsers();
    objposterrUsers.createTableUsers();
    final posterrPosts objposterrPosts = posterrPosts();
    objposterrPosts.createTablePosts();

    return MaterialApp(
      title: 'Posterr',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Splash(),
    );
  }
}


