class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body']);
  }
}

class Comment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return new Comment(
        postId: json['postId'],
        id: json['id'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}

class Picture {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Picture({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return new Picture(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}
