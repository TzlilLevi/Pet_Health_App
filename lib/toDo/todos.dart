import 'package:flutter/cupertino.dart';
import 'package:pet_health_app/models/todo.dart';
import 'package:pet_health_app/toDo/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  // void addTodo(Todo todo) {
  //   // _todos.add(todo);
  //   // notifyListeners();
  // }

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);
  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);
  // void removeTodo(Todo todo) {
  //   _todos.remove(todo);
  //   notifyListeners();
  // }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    //notifyListeners();
    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    FirebaseApi.updateTodo(todo);
    //notifyListeners();
  }
}
