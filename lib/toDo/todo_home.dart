import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_health_app/models/todo.dart';
import 'package:pet_health_app/toDo/add_todo_dialog.dart';
import 'package:pet_health_app/toDo/completed_list.dart';
import 'package:pet_health_app/toDo/firebase_api.dart';
import 'package:pet_health_app/toDo/todo_list.dart';
import 'package:pet_health_app/toDo/todo_widget.dart';
import 'package:pet_health_app/toDo/todos.dart';
import 'package:provider/provider.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({Key? key}) : super(key: key);

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
      ),
      backgroundColor: Colors.lightBlue[50],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'ToDos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed',
          ),
        ],
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //     stream: FirebaseFirestore.instance.collection('todo').snapshots(),
      //     builder: (context, snapshot) {
      //       if (!snapshot.hasData) return const LinearProgressIndicator();
      //       final provider = Provider.of<TodosProvider>(context);
      //       final todos = snapshot.data;
      //       //provider.setTodos(todos);
      //       return _buildList(context, snapshot.data?.docs ?? []);
      //     }),
      body: StreamBuilder<List<Todo>>(
          stream: FirebaseApi.readTodos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                // if (snapshot.hasError) {
                //   return buildText('Something Went Wrong Try later');
                // } else {
                final todos = snapshot.data;
                final provider = Provider.of<TodosProvider>(context);
                // if (todos != null) {
                provider.setTodos(todos!);
                //  }
                return tabs[selectedIndex];
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const AddTodoDialogWidget();
          },
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    //final User? user = auth.currentUser;
    final todo = Todo.fromSnapshot(snapshot);
    // Stream<QuerySnapshot<Map<String, dynamic>>> collection = FirebaseFirestore
    //     .instance
    //     .collection("todo")
    //     .where('isDone', isEqualTo: 'true')
    //     .orderBy(TodoField.createdTime, descending: true)
    //     .snapshots();
    // // if (collection.isEmpty == true) {
    //   return CardPostDogsForum();
    // }
    return TodoWidget(todo: todo);
  }
}
