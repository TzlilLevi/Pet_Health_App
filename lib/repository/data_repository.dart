import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/post.dart';
import 'package:pet_health_app/models/vaccination.dart';

import '../calendar/event.dart';
import '../models/pet.dart';

class DataRepository {
  // 1
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('pet');

  final CollectionReference collectionEvent =
      FirebaseFirestore.instance.collection('event');

  final CollectionReference collectionForumDogs =
      FirebaseFirestore.instance.collection('ForumDogs');

  // 2
  DocumentReference profileImageRef =
      FirebaseFirestore.instance.collection('pet').doc();

  DocumentReference postDoc =
      FirebaseFirestore.instance.collection('ForumDogs').doc();

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getForumStream(String forumName) {
    return FirebaseFirestore.instance
        .collection('Forum' + forumName)
        .orderBy(PostField.date, descending: false)
        .snapshots();
  }

  // 3
  Future<DocumentReference> addPet(Pet pet) {
    return collection.add(pet.toJson());
  }

  Future<DocumentReference> addEvent(Event event) {
    return collectionEvent.add(event.toJson());
  }

  Future<DocumentReference> addPost(Post post, String forumName) {
    return FirebaseFirestore.instance
        .collection('Forum' + forumName)
        .add(post.toJson());
  }

  // 4
  void updatePet(Pet pet) async {
    await collection.doc(pet.referenceId).update(pet.toJson());
  }

  void updatePost(Post post, String forumName) async {
    await FirebaseFirestore.instance
        .collection('Forum' + forumName)
        .doc(post.referenceId)
        .update(post.toJson());
  }

  void updateComment(Post post, int index) async {
    await collectionForumDogs
        .doc(post.referenceId)
        .update(post.comments![index].toJson());
  }

  void updateVaccin(Pet pet, int index) async {
    await collection
        .doc(pet.referenceId)
        .update(pet.vaccinations[index].toJson());
  }

  // 5
  void deletePet(Pet pet) async {
    await collection.doc(pet.referenceId).delete();
  }

  //await saveImages(_images,sightingRef);

}
