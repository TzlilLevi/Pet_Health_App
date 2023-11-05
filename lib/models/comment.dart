import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/models/user.dart';

class Comment {
  String userEmail;
  String body;
  final DateTime date;
  String? referenceId;

  Comment(
      {required this.userEmail,
      required this.body,
      required this.date,
      this.referenceId});

  factory Comment.fromSnapshot(DocumentSnapshot snapshot) {
    final newComment =
        Comment.fromJson(snapshot.data() as Map<String, dynamic>);
    newComment.referenceId = snapshot.reference.id;
    return newComment;
  }

  factory Comment.fromJson(Map<String, dynamic> json) => _commentFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _commentToJson(this);

  @override
  String toString() => 'Comment<$date>';
}

Comment _commentFromJson(Map<String, dynamic> json) {
  return Comment(
    userEmail: json['userEmail'] as String,
    body: json['body'] as String,
    date: (json['date'] as Timestamp).toDate(),
  );
}

// 2
Map<String, dynamic> _commentToJson(Comment instance) => <String, dynamic>{
      'userEmail': instance.userEmail,
      'body': instance.body,
      'date': instance.date,
    };
