import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  // 1
  final String foodName;
  final int amount;
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Food(
      {required this.foodName,
      required this.amount,
      required this.date,
      required this.hour,
      required this.minutes});

  factory Food.fromJson(Map<String, dynamic> json) => _foodFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _foodToJson(this);

  @override
  String toString() => 'Food<$hour>';
}

// 1
Food _foodFromJson(Map<String, dynamic> json) {
  return Food(
    foodName: json['foodName'] as String,
    date: (json['date'] as Timestamp).toDate(),
    amount: json['amount'] as int,
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _foodToJson(Food instance) => <String, dynamic>{
      'foodName': instance.foodName,
      'amount': instance.amount,
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
