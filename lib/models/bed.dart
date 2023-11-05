import 'package:cloud_firestore/cloud_firestore.dart';

class Bed {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Bed({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Bed.fromJson(Map<String, dynamic> json) => _bedCollarFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _bedToJson(this);

  @override
  String toString() => 'Bed<$date>';
}

// 1
Bed _bedCollarFromJson(Map<String, dynamic> json) {
  return Bed(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _bedToJson(Bed instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
