import 'package:cloud_firestore/cloud_firestore.dart';

class Ears {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Ears({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Ears.fromJson(Map<String, dynamic> json) => _earsFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _earsToJson(this);

  @override
  String toString() => 'Ears<$date>';
}

// 1
Ears _earsFromJson(Map<String, dynamic> json) {
  return Ears(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _earsToJson(Ears instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
