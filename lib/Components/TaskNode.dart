import 'package:flutter/material.dart';

class TaskNode extends StatefulWidget {
  String? taskName;
  int? taskNumber;

  @override
  State<TaskNode> createState() => _TaskNodeState();

  TaskNode(String Todo,int TaskNo){
    taskName = Todo;
    taskNumber = TaskNo;
  }

}

class _TaskNodeState extends State<TaskNode> {
  bool? completed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: () {
          print('Task Clicked');
        },
        leading: Text("${widget.taskNumber}"),
        title: Text("${widget.taskName}"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          ),
        tileColor: Colors.white,
        textColor: Colors.black,
        trailing: IconButton(
          onPressed: (){
            setState(() {
              completed = (completed == false)? true:false;
              print("The State is : ${completed}");
            });
          },
         icon: (completed == false)?Icon(Icons.check_box_outline_blank):Icon(Icons.check_box)  
         ), 
        ),
      );
  }
}