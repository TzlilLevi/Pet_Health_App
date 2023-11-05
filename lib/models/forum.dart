import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/models/post.dart';

class Forum {
  String subject;
  List<Post>? posts;

  Forum({required this.subject, this.posts});

  factory Forum.fromJson(Map<String, dynamic> json) => _forumFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _forumToJson(this);

  @override
  String toString() => 'Forum<$subject>';
}

Forum _forumFromJson(Map<String, dynamic> json) {
  return Forum(
    subject: json['subject'] as String,
    posts: _convertPosts(json['posts'] as List<dynamic>),
  );
}

Map<String, dynamic> _forumToJson(Forum instance) => <String, dynamic>{
      'subject': instance.subject,
      'posts': _postList(instance.posts),
    };

List<Post> _convertPosts(List<dynamic> postMap) {
  final posts = <Post>[];

  for (final post in postMap) {
    posts.add(Post.fromJson(post as Map<String, dynamic>));
  }
  return posts;
}

List<Map<String, dynamic>>? _postList(List<Post>? posts) {
  if (posts == null) {
    return null;
  }
  final postMap = <Map<String, dynamic>>[];
  posts.forEach((post) {
    postMap.add(post.toJson());
  });
  return postMap;
}
