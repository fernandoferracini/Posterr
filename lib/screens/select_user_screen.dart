import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/posterr_general.dart';
import 'package:posterr/components/globals.dart' as globals;

class SelectUser extends StatefulWidget {

  @override
  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  final TextEditingController _valueController = TextEditingController();
  String _enteredText = '';
  final posterrPosts objposterrPosts = posterrPosts();
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
      ),
      body: buildSingleChildScrollView(context),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child:GestureDetector(
                  onTap: () {
                    globals.loggedUser = '@fernandoferracini';
                    Navigator.pop(context);
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person_rounded, color: Colors.purple, size: 70.0),
                          title: Text('Fernando Ferracini',style: TextStyle(color: Colors.purple, fontSize: 28.0)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '@fernandoferracini',
                                      style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Date joined Posterr: May 02, 2022',
                                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:GestureDetector(
                    onTap: () {
                      globals.loggedUser = '@generaleia';
                      Navigator.pop(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person_rounded, color: Colors.purple, size: 70.0),
                            title: Text('Leia Organa',style: TextStyle(color: Colors.purple, fontSize: 28.0)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '@generaleia',
                                        style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Date joined Posterr: May 02, 2022',
                                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:GestureDetector(
                    onTap: () {
                      globals.loggedUser = '@lukesky';
                      Navigator.pop(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person_rounded, color: Colors.purple, size: 70.0),
                            title: Text('Luke Skywalker',style: TextStyle(color: Colors.purple, fontSize: 28.0)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '@lukesky',
                                        style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Date joined Posterr: May 02, 2022',
                                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:GestureDetector(
                    onTap: () {
                      globals.loggedUser = '@solo';
                      Navigator.pop(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person_rounded, color: Colors.purple, size: 70.0),
                            title: Text('Han solo',style: TextStyle(color: Colors.purple, fontSize: 28.0)),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '@solo',
                                        style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20.0),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Date joined Posterr: May 02, 2022',
                                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      );
  }
}
