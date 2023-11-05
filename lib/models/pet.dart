import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/Hygiene/bath_list.dart';
import 'package:pet_health_app/models/anti_flea.dart';
import 'package:pet_health_app/models/bed.dart';
import 'package:pet_health_app/models/ears.dart';
import 'package:pet_health_app/models/food.dart';
import 'package:pet_health_app/models/food_plate.dart';
import 'package:pet_health_app/models/hair.dart';
import 'package:pet_health_app/models/height.dart';
import 'package:pet_health_app/models/leash_and_collar.dart';
import 'package:pet_health_app/models/medication.dart';
import 'package:pet_health_app/models/nails.dart';
import 'package:pet_health_app/models/teeth.dart';
import 'package:pet_health_app/models/toys.dart';
import 'package:pet_health_app/models/vaccination.dart';
import 'package:pet_health_app/models/bath.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pet_health_app/models/vetVisits.dart';
import 'package:pet_health_app/models/walk.dart';
import 'package:pet_health_app/models/water_fountain.dart';
import 'package:pet_health_app/models/weight.dart';

import 'vaccination.dart';

part 'pet.g.dart';

@JsonSerializable(explicitToJson: true)
class Pet {
  String name;
  String? uid;
  String? notes;
  String type;
  List<Vaccination> vaccinations;
  List<Bath> bathes;
  List<Teeth> teeth;
  List<Food> food;
  String? referenceId;
  String? profileImage;
  String gender;
  DateTime birthday;
  List<String>? gallery;
  List<Weight>? weight;
  List<Height>? height;
  List<VetVistis> vetVisits;
  List<Medication> medications;
  List<LeashAndCollar> leashesAndCollars;
  List<Toys> toys;
  List<Bed> beds;
  List<WaterFountain> waterFountain;
  List<FoodPlate> foodPlate;
  List<Hair> hair;
  List<Nails> nails;
  List<AntiFlea> antiFlea;
  List<Ears> ears;
  List<Walk> walk;

  Pet(this.name,
      {this.notes,
      this.uid,
      required this.type,
      this.referenceId,
      this.profileImage =
          'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
      required this.vaccinations,
      required this.bathes,
      required this.teeth,
      required this.food,
      required this.gender,
      required this.birthday,
      required this.vetVisits,
      required this.medications,
      required this.leashesAndCollars,
      required this.toys,
      required this.beds,
      required this.waterFountain,
      required this.foodPlate,
      required this.hair,
      required this.nails,
      required this.ears,
      required this.antiFlea,
      required this.walk,
      this.gallery,
      this.weight,
      this.height});

  factory Pet.fromSnapshot(DocumentSnapshot snapshot) {
    final newPet = Pet.fromJson(snapshot.data() as Map<String, dynamic>);
    newPet.referenceId = snapshot.reference.id;
    return newPet;
  }

  factory Pet.fromJson(Map<String, dynamic> json) => _$PetFromJson(json);

  Map<String, dynamic> toJson() => _$PetToJson(this);

  @override
  String toString() => 'Pet<$name>';
//   factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

//   Map<String, dynamic> toJson() => _petToJson(this);

//   @override
//   String toString() => 'Pet<$name>';
// }

// Pet _petFromJson(Map<String, dynamic> json) {
//   return Pet(
//     json['name'] as String,
//     notes: json['notes'] as String?,
//     type: json['type'] as String,
//     birthday: (json['birthday'] as Timestamp).toDate(),
//     gender: json['gender'] as String,
//     profileImage: json['profileImage'] as String?,
//     uid: json['uid'] as String?,
//     vaccinations: _convertVaccinations(json['vaccinations'] as List<dynamic>),
//     bathes: _convertBathes(json['bathes'] as List<dynamic>),
//     gallery: (jsonDecode('gallery') as List<dynamic>).cast<String>(),
//   );
// }

// List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
//   final vaccinations = <Vaccination>[];

//   for (final vaccination in vaccinationMap) {
//     vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
//   }
//   return vaccinations;
// }

// List<Bath> _convertBathes(List<dynamic> bathMap) {
//   final bathes = <Bath>[];

//   for (final bath in bathMap) {
//     bathes.add(Bath.fromJson(bath as Map<String, dynamic>));
//   }
//   return bathes;
// }

// Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
//       'name': instance.name,
//       'notes': instance.notes,
//       'type': instance.type,
//       'profileImage': instance.profileImage,
//       'gender': instance.gender,
//       'birthday': instance.birthday,
//       'uid': instance.uid,
//       'vaccinations': _vaccinationList(instance.vaccinations),
//       'bathes': _bathList(instance.bathes),
//       'gallery': jsonEncode(instance.gallery),
//     };

// List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
//   if (vaccinations == null) {
//     return null;
//   }
//   final vaccinationMap = <Map<String, dynamic>>[];
//   vaccinations.forEach((vaccination) {
//     vaccinationMap.add(vaccination.toJson());
//   });
//   return vaccinationMap;
// }

// List<Map<String, dynamic>>? _bathList(List<Bath>? bathes) {
//   if (bathes == null) {
//     return null;
//   }
//   final bathMap = <Map<String, dynamic>>[];
//   bathes.forEach((bath) {
//     bathMap.add(bath.toJson());
//   });
//   return bathMap;
// }

// class Pet {
//   final String uid;
//   final String pid;
//   String name;
//   String species;
//   String gender;
//   String breed;
//   DateTime birthday;
//   String profileImage;
//   String? notes;
//   List<Vaccination> vaccinations;

//   Pet(String json,
//       {
//       required this.uid,
//       required this.pid,
//       required this.name,
//       required this.species,
//       required this.gender,
//       required this.breed,
//       required this.birthday,
//       required this.profileImage,
//       required this.notes,
//       required this.vaccinations
//       });

//   factory Pet.fromJson(Map<String, dynamic> json) => _petFromJson(json);

//   String? get referenceId => null;

//   Map<String, dynamic> toJson() => _petToJson(this);

//   @override
//   String toString() => 'Pet<$pid>';
// }

// Pet _petFromJson(Map<String, dynamic> json) {
//   return Pet(json['pid'] as String,
//       uid: json['uid'] as String,
//       name: json['name'] as String,
//       species: json['species'] as String,
//       gender: json['gender'] as String,
//       breed: json['breed'] as String,
//       birthday: (json['birthday'] as Timestamp).toDate(),
//       pid: '',
//       profileImage: json['profileImage'] as String,
//       notes: json['notes'] as String,
//       vaccinations:
//           _convertVaccinations(json['vaccinations'] as List<dynamic>));
// }

// List<Vaccination> _convertVaccinations(List<dynamic> vaccinationMap) {
//   final vaccinations = <Vaccination>[];

//   for (final vaccination in vaccinationMap) {
//     vaccinations.add(Vaccination.fromJson(vaccination as Map<String, dynamic>));
//   }
//   return vaccinations;
// }

// // 2
// Map<String, dynamic> _petToJson(Pet instance) => <String, dynamic>{
//       "uid": instance.uid,
//       "pid": instance.pid,
//       "name": instance.name,
//       "species": instance.species,
//       "gender": instance.gender,
//       "breed": instance.breed,
//       "birthday": instance.birthday,
//       "profileImage": instance.profileImage,
//       "notes": instance.notes,
//       'vaccinations': _vaccinationList(instance.vaccinations),
//     };

// List<Map<String, dynamic>>? _vaccinationList(List<Vaccination>? vaccinations) {
//   if (vaccinations == null) {
//     return null;
//   }
//   final vaccinationMap = <Map<String, dynamic>>[];
//   vaccinations.forEach((vaccination) {
//     vaccinationMap.add(vaccination.toJson());
//   });
//   return vaccinationMap;
// }
}
