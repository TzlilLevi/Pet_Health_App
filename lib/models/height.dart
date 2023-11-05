import 'package:cloud_firestore/cloud_firestore.dart';

class Height {
  // 1
  final DateTime date;
  final double height;
  // 2
  Height({required this.date, required this.height});

  factory Height.fromJson(Map<String, dynamic> json) => _heightFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _heightToJson(this);

  @override
  String toString() => 'Height<$date>';
}

// 1
Height _heightFromJson(Map<String, dynamic> json) {
  return Height(
    date: (json['date'] as Timestamp).toDate(),
    height: json['height'] as double,
  );
}

// 2
Map<String, dynamic> _heightToJson(Height instance) => <String, dynamic>{
      'date': instance.date,
      'height': instance.height,
    };
