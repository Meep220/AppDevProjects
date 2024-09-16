import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Todolist extends StatelessWidget {
  const Todolist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('  Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Provider.of<TodoList>(context, listen: false)
                            .completeAllTasks();
                      },
                      child: Text('Check All'),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<TodoList>(
                    builder: (context, todoList, child) {
                      return ListView.builder(
                        itemCount: todoList.tasks.length,
                        itemBuilder: (context, index) {
                          final task = todoList.tasks[index];
                          return ListTile(
                            leading: Text('${task.number}.'),  // Permanent task number
                            title: Text(task.description),
                            trailing: IconButton(
                              icon: Icon(Icons.check_box_outline_blank),
                              onPressed: () {
                                todoList.completeTask(index);
                                
                              },
                              tooltip: "Add Task Here",
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('  Completed Tasks',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {
                        Provider.of<TodoList>(context, listen: false)
                            .uncompleteAllTasks();
                      },
                      child: Text('Uncheck All'),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer<TodoList>(
                    builder: (context, todoList, child) {
                      return ListView.builder(
                        itemCount: todoList.completedTasks.length,
                        itemBuilder: (context, index) {
                          final completedTask = todoList.completedTasks[index];
                          return ListTile(
                            leading: Text('${completedTask.number}.'),  // Same permanent number
                            title: Text(
                              completedTask.description,
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.check_box),
                              onPressed: () {
                                todoList.uncompleteTask(index);
                              },
                              tooltip: "Add Task Here",
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AddTaskWidget(),
          ),
        ],
      ),
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter task here',
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              Provider.of<TodoList>(context, listen: false)
                  .addTask(_controller.text);
              _controller.clear();
            }
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}


class Task {
  final int number;  // Permanent task number
  final String description;

  Task(this.number, this.description);
}

class TodoList extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> _completedTasks = [];
  int _taskCounter = 1;  // Counter to assign permanent task numbers

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _completedTasks;

  // Adding a task with a permanent number
  void addTask(String description) {
    _tasks.add(Task(_taskCounter, description));
    _taskCounter++;
    _sortTasks();  // Sort tasks by number after adding
    notifyListeners();
  }

  // Completing a task and sorting both lists
  void completeTask(int index) {
    Task completedTask = _tasks.removeAt(index);
    _completedTasks.add(completedTask);
    _sortTasks();  // Sort both to-do and completed tasks after moving
    notifyListeners();
  }

  // Uncompleting a task and sorting both lists
  void uncompleteTask(int index) {
    Task uncompletedTask = _completedTasks.removeAt(index);
    _tasks.add(uncompletedTask);
    _sortTasks();  // Sort both to-do and completed tasks after moving
    notifyListeners();
  }

  // Mass complete all tasks
  void completeAllTasks() {
    _completedTasks.addAll(_tasks);
    _tasks.clear();
    _sortTasks();
    notifyListeners();
  }

  // Mass uncomplete all tasks
  void uncompleteAllTasks() {
    _tasks.addAll(_completedTasks);
    _completedTasks.clear();
    _sortTasks();
    notifyListeners();
  }

  // Sorting tasks by their permanent task number
  void _sortTasks() {
    _tasks.sort((a, b) => a.number.compareTo(b.number));  // Sort by task number
    _completedTasks.sort((a, b) => a.number.compareTo(b.number));  // Sort completed tasks by number
  }
}
