import 'package:cloud_firestore/cloud_firestore.dart';

class Bath {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Bath({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory Bath.fromJson(Map<String, dynamic> json) => _bathFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _bathToJson(this);

  @override
  String toString() => 'Bath<$date>';
}

// 1
Bath _bathFromJson(Map<String, dynamic> json) {
  return Bath(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _bathToJson(Bath instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
