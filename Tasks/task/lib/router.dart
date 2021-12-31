
import 'package:flutter/material.dart';
import 'package:task/models/task.dart';
import 'package:task/screens/task_add.dart';
import 'package:task/screens/task_edit.dart';
import 'package:task/screens/task_list.dart';

class AppRouter {

  Task task = Task();

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  TasksList());
      case '/edit_task':
        return MaterialPageRoute(builder: (_) => EditTask( task: null!,));
      case '/add_task':
        return MaterialPageRoute(builder: (_) => AddTask());
      default:
        return null;
    }
  }
}
