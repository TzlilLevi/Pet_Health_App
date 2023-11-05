import 'package:cloud_firestore/cloud_firestore.dart';

class Nails {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Nails({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Nails.fromJson(Map<String, dynamic> json) => _nailsFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _nailsToJson(this);

  @override
  String toString() => 'Nails<$date>';
}

// 1
Nails _nailsFromJson(Map<String, dynamic> json) {
  return Nails(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _nailsToJson(Nails instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
