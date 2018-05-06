import 'package:posts_sample/models.dart';
import 'package:posts_sample/screens/post_detail.dart';
import 'package:posts_sample/api.dart';
import 'package:flutter/material.dart';

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
            subtitle: Text(post.body,
                maxLines: 1, style: Theme.of(context).textTheme.caption),
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: FutureBuilder(
          future: Api.fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data;
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
