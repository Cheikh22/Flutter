import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task/data/database.dart';
import 'package:task/models/task.dart';

class EditTask extends StatefulWidget {
  final Task task;
  EditTask({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  void initState() {
    super.initState();
    titleController.text = this.widget.task.title!;
    descriptionController.text = this.widget.task.description!;
    date_edit = this.widget.task.date!;
    idController = this.widget.task.id!;
  }

  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String date_edit = '';
  int idController = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit task"),
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
                DeleteTask(this.idController);
              },
              child: Icon(
                Icons.delete,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, left: 1.0, right: 1.0),
        child: ListView(
          children: <Widget>[
            //date time text
            Padding(
              padding: EdgeInsets.only(left: 125.0, right: 20.0),
              child: Text(
                this.date_edit,
              ),
            ),
            // title textfield
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 0.0, left: 5.0, right: 5.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onUpdate(
              idController, titleController.text, descriptionController.text);
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
        backgroundColor: Colours.forestGreen,
        child: const Icon(Icons.check),
      ),
    );
  }

  Future<int> _onUpdate(int id, String title, String description) async {
    String formattedDate = databaseHelper.Dateformatter();
    var task = Task(
        id: id, title: title, description: description, date: formattedDate);
    int saveTask = await databaseHelper.UpdateTask(task);
    return saveTask;
  }

  void DeleteTask(int task) async {
    int del = await databaseHelper.DeleteTask(task);
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
