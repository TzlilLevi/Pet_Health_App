// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      headline: json['headline'] as String,
      body: json['body'] as String,
      userEmail: json['userEmail'] as String,
      date: DateTime.parse(json['date'] as String),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      referenceId: json['referenceId'] as String?,
      likes: json['likes'] as Map<String, dynamic>?,
      likesCount: json['likesCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'headline': instance.headline,
      'body': instance.body,
      'userEmail': instance.userEmail,
      'date': instance.date.toIso8601String(),
      'comments': instance.comments?.map((e) => e.toJson()).toList(),
      'referenceId': instance.referenceId,
      'likes': instance.likes,
      'likesCount': instance.likesCount,
      'isLiked': instance.isLiked,
    };
