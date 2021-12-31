import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/data/database.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/task_edit.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  Task task = Task();
  @override
  void initState() {
    super.initState();
    _getTaskList();
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
        backgroundColor: Colours.darkBlue,
      ),
      body: getTasksListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_task'),
        backgroundColor: Colours.darkBlue,
        child: const Icon(Icons.add),
      ),
    );
  }

  Container getTasksListView() {
    return Container(
      color: Colors.grey[200],
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
        child: FutureBuilder(
          future: _getTaskList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          snapshot.data[index].title!.toUpperCase(),
                          style: TextStyle(
                              color: Colours.black,
                              fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(snapshot.data[index].date!),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditTask(task: snapshot.data[index])));
                          },
                        ),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditTask(task: snapshot.data[index])));
                        },
                      ),
                      Divider(height: 5.0),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future _getTaskList() async {
    final items = await databaseHelper.getTasks();
    List<Task> _tasks = items.map<Task>((json) {
      return Task.fromJson(json);
    }).toList();
    return _tasks;
  }
}
