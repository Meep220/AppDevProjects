import 'package:flutter/material.dart';
import 'Components/Todolist.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To-Do App',
        home: Todolist(),
      ),
    );
  }
}