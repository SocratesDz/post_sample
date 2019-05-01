import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body})
      : super([userId, id, title, body]);

  @override
  String toString() => 'Post { id: $id }';

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class Comment extends Equatable {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({this.postId, this.id, this.name, this.email, this.body})
      : super([postId, id, name, email, body]);

  factory Comment.fromJson(Map<String, dynamic> json) {
    return new Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}

class Picture extends Equatable {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Picture({this.albumId, this.id, this.title, this.url, this.thumbnailUrl})
      : super([albumId, id, title, url, thumbnailUrl]);

  factory Picture.fromJson(Map<String, dynamic> json) {
    return new Picture(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}
