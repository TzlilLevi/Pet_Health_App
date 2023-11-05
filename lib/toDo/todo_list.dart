import 'package:flutter/material.dart';
import 'package:pet_health_app/models/todo.dart';
import 'package:pet_health_app/toDo/todo_widget.dart';
import 'package:pet_health_app/toDo/todos.dart';
import 'package:provider/provider.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty ? Center(child: Text('No todos.', style: TextStyle(fontSize: 20),),) :
    ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Container(height: 8),
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoWidget(todo: todo);
      },
      itemCount: todos.length,
    );
  }
}
