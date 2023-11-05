import 'package:cloud_firestore/cloud_firestore.dart';

class FoodPlate {
  // 1
  final DateTime date;
  int hour;
  int minutes;
  // 2
  FoodPlate({
    required this.date,
    required this.hour,
    required this.minutes,
  });
  // 3
  factory FoodPlate.fromJson(Map<String, dynamic> json) =>
      _foodPlateFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _foodPlateToJson(this);

  @override
  String toString() => 'FoodPlate<$date>';
}

// 1
FoodPlate _foodPlateFromJson(Map<String, dynamic> json) {
  return FoodPlate(
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _foodPlateToJson(FoodPlate instance) => <String, dynamic>{
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
