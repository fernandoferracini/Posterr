import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/circular_progress.dart';
import 'package:posterr/components/centered_message.dart';
import 'package:posterr/components/posterr_general.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final posterrPosts objposterrPosts = posterrPosts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: objposterrPosts.getAllPosts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              print('none');
              break;
            case ConnectionState.waiting:
              print('waiting');
              return CircularProgress();
              break;
            case ConnectionState.active:
              print('active');
              break;
            case ConnectionState.done:
              print('done');
              if (snapshot.hasData) {
                final List<Map<String, dynamic>>? posts = snapshot.data;
                // PosterrGeneral.printLongText(posts.toString());
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Map<String, dynamic> post = posts![index];
                    return _postItem(post);
                  },
                  itemCount: posts?.length,
                );
              }
              break;
          }
          return CenteredMessage(
            'Erro desconhecido',
            icon: Icons.error,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => ContactForm(),
          //   ),
          // ).then((value) => setState(() {
          //   print('voltei');
          // }));
        },
      ),
    );
  }
}

class _postItem extends StatelessWidget {
  final Map<String, dynamic> post;
  const _postItem(this.post);

  @override
  Widget build(BuildContext context) {
    if(post['repostCode'] != null){
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text(post['name']),
              subtitle: Text(
                'Reposted  ' + (post['repostDaysFrom'] > 1 ? (post['repostDaysFrom'].toString() + ' days ago') : post['repostHoursFrom'] < 24 ? (post['repostHoursFrom'].toString() + ' hours ago') : (post['repostMinutesFrom'].toString() + ' minutes ago')).toString(),
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
                      title: Text(post['name']+' . '+(post['postedDaysFrom'] > 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] < 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
                      subtitle: Text(
                        post['username'],
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

                  },
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
              ],
            ),
          ],
        ),
      );
    }else{
      if(post['quoteRepostCode'] != ""){
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text(post['name']),
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

                    },
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
                title: Text(post['name']),
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

                    },
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
                ],
              ),
            ],
          ),
        );
      }
    }
  }
}
