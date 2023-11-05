import 'package:cloud_firestore/cloud_firestore.dart';

class Walk {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Walk({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Walk.fromJson(Map<String, dynamic> json) => _walkFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _walkToJson(this);

  @override
  String toString() => 'Walk<$date>';
}

// 1
Walk _walkFromJson(Map<String, dynamic> json) {
  return Walk(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _walkToJson(Walk instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
