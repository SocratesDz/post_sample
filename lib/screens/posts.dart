import 'package:posts_sample/bloc/bloc.dart';
import 'package:posts_sample/models.dart';
import 'package:posts_sample/screens/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  PostsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc.dispatch(Fetch());
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.dispatch(Fetch());
    }
  }

  ListView itemList(
      List<Post> posts, bool hasReachedMax, ScrollController scrollController) {
    return ListView.builder(
        itemBuilder: (context, position) {
          final post = posts[position];
          return position >= posts.length
              ? CircularProgressIndicator()
              : ListTile(
                  subtitle: Text(post.body,
                      maxLines: 1, style: Theme.of(context).textTheme.caption),
                  title: Text(post.title),
                  onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder: (context, _, __) {
                        return PostDetailPage(
                          post: post,
                        );
                      }, transitionsBuilder: (_, animation, __, child) {
                        return new FadeTransition(
                            opacity: animation, child: child);
                      })),
                );
        },
        itemCount: hasReachedMax ? posts.length : posts.length + 1,
        controller: scrollController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        body: BlocBuilder(
          bloc: _postBloc,
          builder: (BuildContext context, PostState state) {
            if (state is PostLoaded) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return Center(
                  child: Text("No posts"),
                );
              }
              return itemList(posts, state.hasReachedMax, _scrollController);
            } else if (state is PostError) {
              return Center(child: Text("Failed to fetch posts"));
            } else if (state is PostUninitialized) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
