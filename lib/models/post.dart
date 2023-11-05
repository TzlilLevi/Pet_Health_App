import 'dart:collection';
import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/models/comment.dart';

part 'post.g.dart';

@JsonSerializable(explicitToJson: true)
class PostField {
  static const date = 'date';
}

class Post {
  String headline;
  String body;
  String userEmail;
  final DateTime date;
  List<Comment>? comments;
  String? referenceId;
  Map<String, dynamic>? likes;
  int likesCount;
  bool isLiked;

  Post(
      {required this.headline,
      required this.body,
      required this.userEmail,
      required this.date,
      this.comments,
      this.referenceId,
      this.likes,
      this.likesCount = 0,
      this.isLiked = false});

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    final newPost = Post.fromJson(snapshot.data() as Map<String, dynamic>);
    newPost.referenceId = snapshot.reference.id;
    return newPost;
  }
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
  // factory Post.fromJson(Map<String, dynamic> json) => _postFromJson(json);
  // // 4
  // Map<String, dynamic> toJson() => _postToJson(this);

  @override
  String toString() => 'Post<$date>';
}

// Post _postFromJson(Map<String, dynamic> json) {
//   return Post(
//     headline: json['headline'] as String,
//     body: json['body'] as String,
//     userEmail: json['userEmail'] as String,
//     date: (json['date'] as Timestamp).toDate(),
//     comments: _convertComments(json['comments'] as List<dynamic>),
//     likes: json['likes'] as Map<String, bool>,
//     likesCount: json['likesCount'] as int,
//     isLiked: json['isLiked'] as bool,
//   );
// }

// 2
// Map<String, dynamic> _postToJson(Post instance) => <String, dynamic>{
//       'headline': instance.headline,
//       'body': instance.body,
//       'userEmail': instance.userEmail,
//       'date': instance.date,
//       'comments': _commentList(instance.comments),
//       'likes': instance.likes,
//       'likesCount': instance.likesCount,
//       'isLiked': instance.isLiked,
//     };

List<Comment> _convertComments(List<dynamic> commentMap) {
  final comments = <Comment>[];

  for (final comment in commentMap) {
    comments.add(Comment.fromJson(comment as Map<String, dynamic>));
  }
  return comments;
}

List<Map<String, dynamic>>? _commentList(List<Comment>? comments) {
  if (comments == null) {
    return null;
  }
  final commentMap = <Map<String, dynamic>>[];
  comments.forEach((comment) {
    commentMap.add(comment.toJson());
  });
  return commentMap;
}
