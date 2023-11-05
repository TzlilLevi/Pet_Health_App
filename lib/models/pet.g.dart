// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pet _$PetFromJson(Map<String, dynamic> json) => Pet(
      json['name'] as String,
      notes: json['notes'] as String?,
      uid: json['uid'] as String?,
      type: json['type'] as String,
      referenceId: json['referenceId'] as String?,
      profileImage: json['profileImage'] as String? ??
          'https://www.creativefabrica.com/wp-content/uploads/2020/09/01/Dog-paw-vector-icon-logo-design-heart-Graphics-5223218-1-1-580x387.jpg',
      vaccinations: (json['vaccinations'] as List<dynamic>)
          .map((e) => Vaccination.fromJson(e as Map<String, dynamic>))
          .toList(),
      bathes: (json['bathes'] as List<dynamic>)
          .map((e) => Bath.fromJson(e as Map<String, dynamic>))
          .toList(),
      teeth: (json['teeth'] as List<dynamic>)
          .map((e) => Teeth.fromJson(e as Map<String, dynamic>))
          .toList(),
      food: (json['food'] as List<dynamic>)
          .map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
      gender: json['gender'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      vetVisits: (json['vetVisits'] as List<dynamic>)
          .map((e) => VetVistis.fromJson(e as Map<String, dynamic>))
          .toList(),
      medications: (json['medications'] as List<dynamic>)
          .map((e) => Medication.fromJson(e as Map<String, dynamic>))
          .toList(),
      leashesAndCollars: (json['leashesAndCollars'] as List<dynamic>)
          .map((e) => LeashAndCollar.fromJson(e as Map<String, dynamic>))
          .toList(),
      toys: (json['toys'] as List<dynamic>)
          .map((e) => Toys.fromJson(e as Map<String, dynamic>))
          .toList(),
      beds: (json['beds'] as List<dynamic>)
          .map((e) => Bed.fromJson(e as Map<String, dynamic>))
          .toList(),
      waterFountain: (json['waterFountain'] as List<dynamic>)
          .map((e) => WaterFountain.fromJson(e as Map<String, dynamic>))
          .toList(),
      foodPlate: (json['foodPlate'] as List<dynamic>)
          .map((e) => FoodPlate.fromJson(e as Map<String, dynamic>))
          .toList(),
      hair: (json['hair'] as List<dynamic>)
          .map((e) => Hair.fromJson(e as Map<String, dynamic>))
          .toList(),
      nails: (json['nails'] as List<dynamic>)
          .map((e) => Nails.fromJson(e as Map<String, dynamic>))
          .toList(),
      ears: (json['ears'] as List<dynamic>)
          .map((e) => Ears.fromJson(e as Map<String, dynamic>))
          .toList(),
      antiFlea: (json['antiFlea'] as List<dynamic>)
          .map((e) => AntiFlea.fromJson(e as Map<String, dynamic>))
          .toList(),
      walk: (json['walk'] as List<dynamic>)
          .map((e) => Walk.fromJson(e as Map<String, dynamic>))
          .toList(),
      gallery:
          (json['gallery'] as List<dynamic>?)?.map((e) => e as String).toList(),
      weight: (json['weight'] as List<dynamic>?)
          ?.map((e) => Weight.fromJson(e as Map<String, dynamic>))
          .toList(),
      height: (json['height'] as List<dynamic>?)
          ?.map((e) => Height.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PetToJson(Pet instance) => <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'notes': instance.notes,
      'type': instance.type,
      'vaccinations': instance.vaccinations.map((e) => e.toJson()).toList(),
      'bathes': instance.bathes.map((e) => e.toJson()).toList(),
      'teeth': instance.teeth.map((e) => e.toJson()).toList(),
      'food': instance.food.map((e) => e.toJson()).toList(),
      'referenceId': instance.referenceId,
      'profileImage': instance.profileImage,
      'gender': instance.gender,
      'birthday': instance.birthday.toIso8601String(),
      'gallery': instance.gallery,
      'weight': instance.weight?.map((e) => e.toJson()).toList(),
      'height': instance.height?.map((e) => e.toJson()).toList(),
      'vetVisits': instance.vetVisits.map((e) => e.toJson()).toList(),
      'medications': instance.medications.map((e) => e.toJson()).toList(),
      'leashesAndCollars':
          instance.leashesAndCollars.map((e) => e.toJson()).toList(),
      'toys': instance.toys.map((e) => e.toJson()).toList(),
      'beds': instance.beds.map((e) => e.toJson()).toList(),
      'waterFountain': instance.waterFountain.map((e) => e.toJson()).toList(),
      'foodPlate': instance.foodPlate.map((e) => e.toJson()).toList(),
      'hair': instance.hair.map((e) => e.toJson()).toList(),
      'nails': instance.nails.map((e) => e.toJson()).toList(),
      'antiFlea': instance.antiFlea.map((e) => e.toJson()).toList(),
      'ears': instance.ears.map((e) => e.toJson()).toList(),
      'walk': instance.walk.map((e) => e.toJson()).toList(),
    };
