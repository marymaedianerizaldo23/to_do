import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do/todo_item.dart';
import 'package:to_do/todo_service.dart';

void main() async{

  await Hive.initFlutter();
  Hive.registerAdapter(TodoItemAdapter());
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
 MyApp({super.key});

  final TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _todoService.getAllTodos(),
        builder: (BuildContext context, AsyncSnapshot<List<TodoItem>> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return const TodoListPage();
          }
          else {
            return const CircularProgressIndicator();
          }
        },
      )
    );
  }
}


class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive To Do List"),
          backgroundColor: Colors.black,
      ),
    );
  }
}