import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  PostDetailPage({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Post detail")),
        body: Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      this.widget.post.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(this.widget.post.body,
                        style: TextStyle(fontSize: 16.0)))
              ],
            )));
  }

  Widget commentsSection() {
    // TODO: Comment section
    return Container();
  }
}
