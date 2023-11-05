// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      hour: json['hour'] as int,
      minutes: json['minutes'] as int,
      referenceId: json['referenceId'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'hour': instance.hour,
      'minutes': instance.minutes,
      'referenceId': instance.referenceId,
      'uid': instance.uid,
    };
