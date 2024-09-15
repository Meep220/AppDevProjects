import 'package:flutter/material.dart';
import '../Components/TaskNode.dart';

class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        leading: 
          IconButton(
            onPressed: (){},
             icon: const Icon(Icons.add,color: Colors.black,),
             tooltip: "Add Task",
            )
        ,
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: ListView(
              children: [
                ListTile(
                  leading: Text("Item No."),
                  title: Text("Task"),
                  
                ),
                TaskNode("Clean the Dishes",1),
                TaskNode("Clean the floor",2),
                TaskNode("Clean the cat",3),
                TaskNode("Clean the ",4),
                TaskNode("Clean the Dishes",5),
              ],
              
            ),
            ),
          ],
        ),
      ),
    );
  }
}

