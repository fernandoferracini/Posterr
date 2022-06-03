import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/posterr_general.dart';

import '../components/centered_message.dart';
import '../components/circular_progress.dart';

class RepostForm extends StatefulWidget {

  final String postType;
  final String username;
  final int codPost;
  const RepostForm(this.postType,this.username, this.codPost);

  @override
  _RepostFormState createState() => _RepostFormState();
}

class _RepostFormState extends State<RepostForm> {
  final TextEditingController _valueController = TextEditingController();
  String _enteredText = '';
  final posterrPosts objposterrPosts = posterrPosts();
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Repost'),
      ),
      body:FutureBuilder<List<Map<String, dynamic>>>(
        future: objposterrPosts.getPost(widget.codPost),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return CircularProgress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Map<String, dynamic>>? post = snapshot.data;
                // PosterrGeneral.printLongText(post.toString());
                return buildSingleChildScrollView(context, post);
              }
              break;
          }
          return CenteredMessage(
            'Erro desconhecido',
            icon: Icons.error,
          );
        },
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context, post) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_rounded),
                      title: Text('P '+post[0]['name']+' . '+(post[0]['postedDaysFrom'] > 1 ? (post[0]['postedDaysFrom'].toString() + ' days ago') : post[0]['postedHoursFrom'] < 24 ? (post[0]['postedHoursFrom'].toString() + ' hours ago') : (post[0]['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
                      subtitle: Text(
                          post[0]['username'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        post[0]['post'] != null?post[0]['post']: "",
                        style: TextStyle(color: Colors.purple, fontSize: 28.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Repost!'),
                    onPressed: () {
                      final int value = post[0]['codPost'];
                      objposterrPosts.repost(value).then((transaction) {
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
