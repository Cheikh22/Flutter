import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:task/data/database.dart';
import 'package:task/models/task.dart';

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Task> _taskList = <Task>[];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task"),
        backgroundColor: Colours.darkBlue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _onSubmit(titleController.text, descriptionController.text);
                  titleController.clear();
                  descriptionController.clear();
                  Navigator.pushNamedAndRemoveUntil(context,'/' , ( route) => false);
                },
                child: Icon(
                  Icons.check,
                  size: 26.0,
                ),
              ),),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 1.0, right: 1.0),
        child: ListView(
          children: <Widget>[
        //date time text
            Padding(
              padding: EdgeInsets.only( left: 125.0, right: 20.0),
              child: Text(
                databaseHelper.Dateformatter(),
              ),
            ),
            // title textfield
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: ' Title',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w500,fontSize: 17),
                  border: InputBorder.none,
                ),
              ),
            ),
            //description textfield
            Padding(
              padding: EdgeInsets.only(
                  top: 15.0, bottom: 15.0, left: 5.0, right: 1.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                minLines: 26,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<int> _onSubmit(String title, String description) async {
    String formattedDate = databaseHelper.Dateformatter();
    var task =
        Task(title: title, description: description, date: formattedDate);
    int saveTask = await databaseHelper.InsertTask(task);
    return saveTask;
  }
}
