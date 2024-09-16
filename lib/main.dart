import 'package:flutter/material.dart';
import 'Components/Todolist.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To do List App",
      home: Todolist()
    );
  }
}

