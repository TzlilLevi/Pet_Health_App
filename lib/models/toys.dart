import 'package:cloud_firestore/cloud_firestore.dart';

class Toys {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Toys({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Toys.fromJson(Map<String, dynamic> json) => _toysFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _toysToJson(this);

  @override
  String toString() => 'Toys<$date>';
}

// 1
Toys _toysFromJson(Map<String, dynamic> json) {
  return Toys(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _toysToJson(Toys instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
