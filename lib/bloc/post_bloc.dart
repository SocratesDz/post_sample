import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:posts_sample/api.dart';
import 'package:posts_sample/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  
  @override
  Stream<PostState> transform(Stream<PostEvent> events,
      Stream<PostState> Function(PostEvent event) next) {
    return super.transform(
        (events as Observable<PostEvent>).debounce(Duration(milliseconds: 500)),
        next);
  }

  @override
  PostState get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final posts = await Api.fetchPosts(start: 0, limit: 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final posts = await Api.fetchPosts(
              start: (currentState as PostLoaded).posts.length, limit: 20);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;
}
