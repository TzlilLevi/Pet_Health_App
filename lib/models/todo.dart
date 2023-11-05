import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_health_app/toDo/utils.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime? createdTime;
  String title;
  String id;
  String description;
  bool isDone;
  String? uid;
  String? pid;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id = '',
    this.isDone = false,
    this.uid,
    this.pid,
  });

  factory Todo.fromSnapshot(DocumentSnapshot snapshot) {
    final newTodo = Todo.fromJson(snapshot.data() as Map<String, dynamic>);
    newTodo.id = snapshot.reference.id;
    return newTodo;
  }

  static Todo fromJson(Map<String, dynamic> json) => Todo(
        createdTime: Utils.toDateTime(json['createdTime']),
        title: json['title'],
        description: json['description'],
        id: json['id'],
        isDone: json['isDone'],
        uid: json['uid'],
        pid: json['pid'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime!),
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'uid': uid,
        'pid': pid,
      };
}
