import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posterr/components/globals.dart' as globals;
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/posterr_general.dart';
import 'package:posterr/screens/post_form_screen.dart';
import 'package:posterr/screens/quoteRepost_form_screen.dart';
import 'package:posterr/screens/repost_form_screen.dart';
import 'package:posterr/components/centered_message.dart';
import 'package:posterr/components/circular_progress.dart';
import 'package:posterr/screens/select_user_screen.dart';

class User extends StatefulWidget {

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final TextEditingController _valueController = TextEditingController();
  String _enteredText = '';
  final posterrPosts objposterrPosts = posterrPosts();
      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SelectUser(),
                    ),
                  ).then((value) => setState(() {}));
                },
                child: Icon(
                    Icons.person_search
                ),
              )
          ),
        ],
      ),
      body:FutureBuilder<List<Map<String, dynamic>>>(
        future: objposterrPosts.getPostsUsername(globals.loggedUser),
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
                final List<Map<String, dynamic>>? posts = snapshot.data;
                // PosterrGeneral.printLongText(posts.toString());
                posts?.forEach((item) {
                  if(item['username'] == globals.loggedUser){
                    // print('user: '+item['username'].toString()+ 'posts: '+item['postsToday'].toString());
                    if(item['postsToday'] >= 5){
                      globals.limitOfDay = true;
                    }else{
                      globals.limitOfDay = false;
                    }
                  }
                });
                return Column(
                  children: <Widget>[
                    Container(
                      child: buildSingleChildScrollView(context, posts),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final Map<String, dynamic> post = posts![index];
                            return buildPost(post,posts);
                          },
                          itemCount: posts?.length,
                        ),
                      ),
                    )
                  ],
                );
              }
              break;
          }
          return CenteredMessage(
            'Unknow Error',
            icon: Icons.error,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if(globals.limitOfDay == true){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Posterr",style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.purple,
                  content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                  actions: [
                    TextButton(
                      child: Text("OK", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }else{
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostForm('post',globals.loggedUser, 0),
              ),
            ).then((value) => setState(() {}));
          }

        },
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(BuildContext context, posts) {
      // final posterrPosts objposterrPosts = posterrPosts();
      // objposterrPosts.getPostsData(globals.loggedUser);
      // print(PostsData.toString())
    final DateFormat formatter = DateFormat('MMMM d, y');
    DateTime dt = DateTime.parse(posts[0]['joinedDate']);
    String joinedDate = formatter.format(dt);
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
              clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_rounded, color: Colors.purple, size: 70.0),
                      title: Text(posts[0]['name'].toString(),style: TextStyle(color: Colors.purple, fontSize: 28.0)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  globals.loggedUser,
                                  style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Date joined Posterr: '+joinedDate,
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.post_add,
                          ),
                          iconSize: 25,
                          color: Colors.purple,
                          onPressed: () {
                          },
                        ),
                        Text(
                          posts[0]['countPost'].toString(),
                          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 18.0),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.autorenew_rounded,
                          ),
                          iconSize: 25,
                          color: Colors.purple,
                          onPressed: () {
                          },
                        ),
                        Text(
                          posts[0]['countRepost'].toString(),
                          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 18.0),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.create_rounded,
                          ),
                          iconSize: 25,
                          color: Colors.purple,
                          onPressed: () {
                          },
                        ),
                        Text(
                          posts[0]['countQuoteRepost'].toString(),
                          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 18.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Card buildPost(Map<String, dynamic> post, List<Map<String, dynamic>> posts) {
    if(post['repostCode'] != null){
      int indexOriginalPost = 0;
      posts.asMap().forEach((index, item) {
        if(item['codPost'] == post['repostCode']){
          indexOriginalPost = index;
        }
      });
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text(post['name']),
                subtitle: Text(
                  'Reposted  ' + (post['postedDaysFrom'] >= 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] >= 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString(),
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person_rounded),
                      title: Text(post['repostname']+' . '+(posts[indexOriginalPost]['postedDaysFrom'] >= 1 ? (posts[indexOriginalPost]['postedDaysFrom'].toString() + ' days ago') : posts[indexOriginalPost]['postedHoursFrom'] >= 24 ? (posts[indexOriginalPost]['postedHoursFrom'].toString() + ' hours ago') : (posts[indexOriginalPost]['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
                      subtitle: Text(
                        post['repostUsername'],
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        post['repostPost'] != null?post['repostPost']: "",
                        style: TextStyle(color: Colors.purple, fontSize: 28.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.autorenew_rounded,
                  ),
                  iconSize: 25,
                  color: Colors.purple,
                  onPressed: () {
                    if(globals.limitOfDay == true){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Posterr",style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.purple,
                            content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                            actions: [
                              TextButton(
                                child: Text("OK", style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }else{
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RepostForm('repost',globals.loggedUser, post['repostCode']),
                        ),
                      ).then((value) => setState(() {}));
                    }

                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.create_rounded,
                  ),
                  iconSize: 25,
                  color: Colors.purple,
                  onPressed: () {
                    if(globals.limitOfDay == true){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Posterr",style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.purple,
                            content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                            actions: [
                              TextButton(
                                child: Text("OK", style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }else{
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuoteRepostForm('quorepost',globals.loggedUser, post['repostCode']),
                        ),
                      ).then((value) => setState(() {}));
                    }

                  },
                ),
              ],
            ),
          ],
        ),
      );
    }else{
      if(post['quoteRepostCode'] != null){
        int indexOriginalPost = 0;
        posts.asMap().forEach((index, item) {
          if(item['codPost'] == post['quoteRepostCode']){
            indexOriginalPost = index;
          }
        });
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text(post['name']),
                  subtitle: Text(
                    'Reposted  ' + (post['postedDaysFrom'] >= 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] >= 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString(),
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  post['post'] != null?post['post']: "",
                  style: TextStyle(color: Colors.purple, fontSize: 28.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.purple, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person_rounded),
                        title: Text(post['quoteRepostname']+' . '+(posts[indexOriginalPost]['postedDaysFrom'] >= 1 ? (posts[indexOriginalPost]['postedDaysFrom'].toString() + ' days ago') : posts[indexOriginalPost]['postedHoursFrom'] >= 24 ? (posts[indexOriginalPost]['postedHoursFrom'].toString() + ' hours ago') : (posts[indexOriginalPost]['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
                        subtitle: Text(
                          post['username'],
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          post['quoteRepostPost'] != null?post['quoteRepostPost']: "",
                          style: TextStyle(color: Colors.purple, fontSize: 28.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.autorenew_rounded,
                    ),
                    iconSize: 25,
                    color: Colors.purple,
                    onPressed: () {
                      if(globals.limitOfDay == true){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Posterr",style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.purple,
                              content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  child: Text("OK", style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RepostForm('repost',globals.loggedUser, post['quoteRepostCode']),
                          ),
                        ).then((value) => setState(() {}));
                      }

                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.create_rounded,
                    ),
                    iconSize: 25,
                    color: Colors.purple,
                    onPressed: () {
                      if(globals.limitOfDay == true){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Posterr",style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.purple,
                              content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  child: Text("OK", style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuoteRepostForm('quorepost',globals.loggedUser, post['quoteRepostCode']),
                          ),
                        ).then((value) => setState(() {}));
                      }

                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }else{
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text(post['name']+' . '+(post['postedDaysFrom'] >= 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] >= 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
                subtitle: Text(
                  post['username'],
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  post['post'] != null?post['post']: "",
                  style: TextStyle(color: Colors.purple, fontSize: 28.0),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.autorenew_rounded,
                    ),
                    iconSize: 25,
                    color: Colors.purple,
                    onPressed: () {
                      if(globals.limitOfDay == true){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Posterr",style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.purple,
                              content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  child: Text("OK", style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RepostForm('repost',globals.loggedUser, post['codPost']),
                          ),
                        ).then((value) => setState(() {}));
                      }

                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.create_rounded,
                    ),
                    iconSize: 25,
                    color: Colors.purple,
                    onPressed: () {
                      if(globals.limitOfDay == true){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Posterr",style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.purple,
                              content: Text("unfortunately you reached the maximum number of posts per day :( Please try again tomorrow :)",style: TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  child: Text("OK", style: TextStyle(color: Colors.white)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => QuoteRepostForm('quorepost',globals.loggedUser, post['codPost']),
                          ),
                        ).then((value) => setState(() {}));
                      }

                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }
    }
  }

}
