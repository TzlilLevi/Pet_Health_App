import 'package:cloud_firestore/cloud_firestore.dart';

class Vaccination {
  // 1
  final String vaccination;
  final DateTime date;
  int hour;
  int minutes;
  bool? done;
  // 2
  Vaccination(this.vaccination,
      {required this.date,
      required this.hour,
      required this.minutes,
      this.done});
  // 3
  factory Vaccination.fromJson(Map<String, dynamic> json) =>
      _vaccinationFromJson(json);
  // 4
  Map<String, dynamic> toJson() => _vaccinationToJson(this);

  @override
  String toString() => 'Vaccination<$vaccination>';
}

// 1
Vaccination _vaccinationFromJson(Map<String, dynamic> json) {
  return Vaccination(
    json['vaccination'] as String,
    date: (json['date'] as Timestamp).toDate(),
    hour: json['hour'] as int,
    minutes: json['minutes'] as int,
    done: json['done'] as bool,
  );
}

// 2
Map<String, dynamic> _vaccinationToJson(Vaccination instance) =>
    <String, dynamic>{
      'vaccination': instance.vaccination,
      'date': instance.date,
      'hour': instance.hour,
      'minutes': instance.minutes,
      'done': instance.done,
    };
