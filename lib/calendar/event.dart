import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  final String title;
  final DateTime date;
  int hour;
  int minutes;
  String? referenceId;
  String? uid;

  Event({
    required this.title,
    required this.date,
    required this.hour,
    required this.minutes,
    this.referenceId,
    this.uid,
  });

  factory Event.fromSnapshot(DocumentSnapshot snapshot) {
    final newEvent = Event.fromJson(snapshot.data() as Map<String, dynamic>);
    newEvent.referenceId = snapshot.reference.id;
    return newEvent;
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

  @override
  String toString() => 'Event<$title>';
}
