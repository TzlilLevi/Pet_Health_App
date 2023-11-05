import 'package:cloud_firestore/cloud_firestore.dart';

class WaterFountain {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  WaterFountain({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory WaterFountain.fromJson(Map<String, dynamic> json) =>
      _waterFountainFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _waterFountainToJson(this);

  @override
  String toString() => 'WaterFountain<$date>';
}

// 1
WaterFountain _waterFountainFromJson(Map<String, dynamic> json) {
  return WaterFountain(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _waterFountainToJson(WaterFountain instance) =>
    <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
