import 'dart:async';
import 'dart:convert';
import '../models.dart';
import 'post_detail.dart';
import '../api.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  PostsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  ListView itemList(List<Post> posts) {
    return ListView.builder(
        itemBuilder: (context, position) {
          final post = posts[position];
          return ListTile(
            title: Text(post.title),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PostDetailPage(
                          post: post,
                        ))),
          );
        },
        itemCount: posts.length);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: FutureBuilder(
          future: Api.fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = (snapshot.data as List<Post>);
              return itemList(posts);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
