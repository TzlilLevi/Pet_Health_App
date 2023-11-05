import 'package:cloud_firestore/cloud_firestore.dart';

class LeashAndCollar {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  LeashAndCollar({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory LeashAndCollar.fromJson(Map<String, dynamic> json) =>
      _leashAndCollarFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _leashAndCollarToJson(this);

  @override
  String toString() => 'LeashAndCollar<$date>';
}

// 1
LeashAndCollar _leashAndCollarFromJson(Map<String, dynamic> json) {
  return LeashAndCollar(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _leashAndCollarToJson(LeashAndCollar instance) =>
    <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
