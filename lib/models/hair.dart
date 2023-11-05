import 'package:cloud_firestore/cloud_firestore.dart';

class Hair {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Hair({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Hair.fromJson(Map<String, dynamic> json) => _hairFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _hairToJson(this);

  @override
  String toString() => 'Hair<$date>';
}

// 1
Hair _hairFromJson(Map<String, dynamic> json) {
  return Hair(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _hairToJson(Hair instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
