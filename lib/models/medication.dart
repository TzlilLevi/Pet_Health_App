import 'package:cloud_firestore/cloud_firestore.dart';

class Medication {
  // 1
  final String medicationName;
  final int amount;
  final DateTime date;
  int hour;
  int minutes;
  // 2
  Medication(
      {required this.medicationName,
      required this.amount,
      required this.date,
      required this.hour,
      required this.minutes});

  factory Medication.fromJson(Map<String, dynamic> json) => _medicationFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _medicationToJson(this);

  @override
  String toString() => 'Medication<$hour>';
}

// 1
Medication _medicationFromJson(Map<String, dynamic> json) {
  return Medication(
    medicationName: json['medicationName'] as String,
    date: (json['date'] as Timestamp).toDate(),
    amount: json['amount'] as int,
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
  );
}

// 2
Map<String, dynamic> _medicationToJson(Medication instance) => <String, dynamic>{
      'medicationName': instance.medicationName,
      'amount': instance.amount,
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
    };
