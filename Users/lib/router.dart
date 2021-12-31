import 'package:flutter/material.dart';
import 'package:notes/models/user.dart';
import 'package:notes/pages/form.dart';
import 'package:notes/pages/list.dart';


class AppRouter {

  User user = User();

  Route? generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(builder: (_) =>  MyList());
      case '/add_user':
        return MaterialPageRoute(builder: (_) => MyForm(user:User(id:0,name: '',email: '',password: '')));
      default:
        return null;
    }
  }
}
