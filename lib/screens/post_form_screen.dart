import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/posterr_general.dart';
import 'package:posterr/components/globals.dart' as globals;

class PostForm extends StatefulWidget {

  final String postType;
  final String username;
  final int codPost;
  const PostForm(this.postType,this.username, this.codPost);

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final TextEditingController _valueController = TextEditingController();
  String _enteredText = '';
  final posterrPosts objposterrPosts = posterrPosts();
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Post'),
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
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _enteredText = value;
                    });
                  },
                  controller: _valueController,
                  maxLines: 5,
                  maxLength: 777,
                  buildCounter: (
                      context, { required currentLength, required isFocused, maxLength }) {
                    int utf8Length = utf8.encode(_valueController.text).length;
                    return Container(
                      child: Text(
                        '$utf8Length/$maxLength',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  },
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(
                      labelText: 'Type your message...',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Post!'),
                    onPressed: () {
                      final String value = _valueController.text;
                      objposterrPosts.post(globals.loggedUser, value).then((transaction) {
                        if (transaction != null) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      );
  }
}
