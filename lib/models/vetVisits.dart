import 'package:cloud_firestore/cloud_firestore.dart';

class VetVistis {
  // 1
  final String clinicName;
  final String treatmeantType;
  final DateTime date;
  int hour;
  int minutes;
  bool? done;
  // 2
  VetVistis({
    required this.date,
    required this.hour,
    required this.minutes,
    this.done,
    required this.clinicName,
    required this.treatmeantType,
  });
  // 3
  factory VetVistis.fromJson(Map<String, dynamic> json) =>
      _vetVisitFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _vetVisitsToJson(this);

  @override
  String toString() => 'VetVistis<$treatmeantType>';
}

// 1
VetVistis _vetVisitFromJson(Map<String, dynamic> json) {
  return VetVistis(
    clinicName: json['clinicName'] as String,
    treatmeantType: json['treatmeantType'] as String,
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
    done: json['done'] as bool,
  );
}

// 2
Map<String, dynamic> _vetVisitsToJson(VetVistis instance) => <String, dynamic>{
      'clinicName': instance.clinicName,
      'treatmeantType': instance.treatmeantType,
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
      'done': instance.done,
    };
