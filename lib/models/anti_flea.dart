import 'package:cloud_firestore/cloud_firestore.dart';

class AntiFlea {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  AntiFlea({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory AntiFlea.fromJson(Map<String, dynamic> json) =>
      _antiFleaFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _antiFleaToJson(this);

  @override
  String toString() => 'AntiFlea<$date>';
}

// 1
AntiFlea _antiFleaFromJson(Map<String, dynamic> json) {
  return AntiFlea(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _antiFleaToJson(AntiFlea instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
