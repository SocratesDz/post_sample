import 'package:flutter/material.dart';
import 'package:posts_sample/models.dart';
import 'package:posts_sample/api.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;
  PostDetailPage({Key key, this.post}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  List<Comment> _comments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(pinned: true, title: Text("Post detail"))
              ];
            },
            body: new CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: SliverToBoxAdapter(
                        child: Text(
                      this.widget.post.title,
                      style: Theme.of(context).textTheme.display1,
                    ))),
                SliverPadding(
                    padding: const EdgeInsets.all(10.0),
                    sliver: SliverToBoxAdapter(
                        child: Text(this.widget.post.body,
                            style: Theme.of(context).textTheme.body1))),
                SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text("Comments",
                                  style: Theme.of(context).textTheme.title)),
                          //Icon(Icons.filter_list)
                        ],
                      ),
                    )),
                FutureBuilder(
                  future: Api.fetchComments(this.widget.post.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final comments = snapshot.data;
                      return SliverList(
                          delegate: _commentsList(comments).childrenDelegate);
                    } else if (snapshot.hasError) {
                      print("Error loading comments: ${snapshot.error}");
                      return SliverToBoxAdapter(child: Text("No comments."));
                    }
                    return SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  },
                )
              ],
            )));
  }

  ListView _commentsList(List<Comment> comments) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, position) {
        final comment = comments[position];
        return CommentWidget(comment: comment);
      },
      itemCount: comments.length,
    );
  }
}

class CommentWidget extends StatelessWidget {
  CommentWidget({Key key, this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              comment.name,
              style: Theme.of(context).textTheme.body2,
            ),
            Text(
              comment.email,
              style: Theme.of(context).textTheme.caption,
            ),
            Text(
              comment.body,
              style: Theme.of(context).textTheme.body1,
            )
          ],
        ));
  }
}
