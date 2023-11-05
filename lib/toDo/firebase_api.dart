import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_health_app/models/todo.dart';
import 'package:pet_health_app/toDo/utils.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    print("Linoy print error: " + auth.currentUser!.uid);
    return FirebaseFirestore.instance
        .collection('todo')
        //.where("uid", isEqualTo: user!.uid)
        .orderBy(TodoField.createdTime, descending: false)
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson));
  }

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
