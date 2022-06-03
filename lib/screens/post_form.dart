import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';

class PostForm extends StatefulWidget {

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
      body: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(
                        labelText: 'Type your message...',
                        border: OutlineInputBorder(),
                        counterText: '${(777 - _enteredText.length).toString()} character(s) left.'),
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
                      objposterrPosts.post(value).then((transaction) {
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
      ),
    );
  }
}
