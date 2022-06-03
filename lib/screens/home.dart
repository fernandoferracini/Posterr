import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/circular_progress.dart';
import 'package:posterr/components/centered_message.dart';
import 'package:posterr/screens/post_form.dart';
import 'package:posterr/screens/repost_form.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
                return ListView.builder(
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> post = posts![index];
                        return buildPost(post);
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostForm('post','@fernandoferracini', 1),
            ),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }

  Card buildPost(Map<String, dynamic> post) {
    if(post['repostCode'] != null){
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text('R '+post['name']),
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
                      title: Text(post['repostname']+' . '+(post['postedDaysFrom'] > 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] < 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
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
      if(post['quoteRepostCode'] != null){
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                  leading: Icon(Icons.person_rounded),
                  title: Text('Q '+post['name']),
                  subtitle: Text(
                    'Reposted  ' + (post['quoteRepostDaysFrom'] > 1 ? (post['quoteRepostDaysFrom'].toString() + ' days ago') : post['quoteRepostHoursFrom'] < 24 ? (post['quoteRepostHoursFrom'].toString() + ' hours ago') : (post['quoteRepostMinutesFrom'].toString() + ' minutes ago')).toString(),
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
                        title: Text(post['quoteRepostname']+' . '+(post['postedDaysFrom'] > 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] < 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
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
                      // _controller.open();
                      // setState(() {
                      //   _button = 'Open Drawer';
                      // });
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
                title: Text('P '+post['name']+' . '+(post['postedDaysFrom'] > 1 ? (post['postedDaysFrom'].toString() + ' days ago') : post['postedHoursFrom'] < 24 ? (post['postedHoursFrom'].toString() + ' hours ago') : (post['postedMinutesFrom'].toString() + ' minutes ago')).toString()),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RepostForm('repost','@fernandoferracini', post['codPost']),
                        ),
                      ).then((value) => setState(() {}));
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





