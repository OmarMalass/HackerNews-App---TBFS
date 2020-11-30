import 'package:flutter/material.dart';
import 'package:hacker_news/article.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        child: ListView(children: _articles.map(_buildItem).toList()),
        onRefresh: () async {
          await new Future.delayed(const Duration(seconds: 1));
          setState(() {
            _articles.removeAt(0);
          });
          return;
        },
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ExpansionTile(
        title: new Text(
          article.text,
//          style: new TextStyle(fontSize: 10.0),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${article.commentsCount} Comments"),
              new IconButton(
                  onPressed: () async {
                    String url = "https://${article.domain}";
                    if (await canLaunch(url)) launch(url);
                  },
                  icon: new Icon(Icons.launch))
            ],
          )
        ],
//        subtitle: new Text("${article.commentsCount} Comments"),
      ),
    );
  }
}
