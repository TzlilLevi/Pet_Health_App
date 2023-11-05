import 'package:cloud_firestore/cloud_firestore.dart';

class Teeth {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Teeth({
    required this.date,
    required this.hour,
    required this.minutes,
  });

  factory Teeth.fromJson(Map<String, dynamic> json) => _teethFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _teethToJson(this);

  @override
  String toString() => 'Teeth<$date>';
}

// 1
Teeth _teethFromJson(Map<String, dynamic> json) {
  return Teeth(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _teethToJson(Teeth instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
