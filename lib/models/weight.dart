import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  // 1
  final DateTime date;
  final double weight;
  // 2
  Weight({required this.date, required this.weight});

  factory Weight.fromJson(Map<String, dynamic> json) => _weightFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _weightToJson(this);

  @override
  String toString() => 'Weight<$date>';
}

// 1
Weight _weightFromJson(Map<String, dynamic> json) {
  return Weight(
    date: (json['date'] as Timestamp).toDate(),
    weight: json['weight'] as double,
  );
}

// 2
Map<String, dynamic> _weightToJson(Weight instance) => <String, dynamic>{
      'date': instance.date,
      'weight': instance.weight,
    };
