import 'package:flutter/material.dart';
import 'package:posterr/dao/posterr_posts_class.dart';
import 'package:posterr/components/circular_progress.dart';
import 'package:posterr/components/centered_message.dart';

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
              break;
            case ConnectionState.waiting:
              return CircularProgress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Map<String, dynamic>>? posts = snapshot.data;
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
    return Card(
      child: ListTile(
        title: Text(
          post['username'].toString(),
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text('Conta: ' + post['name'].toString(),
            style: TextStyle(fontSize: 16.0)),
      ),
    );
  }
}
