import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:notes/models/user.dart';
import 'package:notes/pages/list.dart';

const darkBlueColor = Color(0xff486579);

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  final _formKey = GlobalKey<FormState>();
  List<User> _users =[];
  User _user = User();
  final  apiUrl = Uri.parse('http://10.0.2.2:8000/user');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Form(
        key: _formKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: '  name'),
              onSaved: (val) => setState(() => _user.name = val!),
              validator: (val) =>
                  (val!.length == 0 ? 'this field is required' : null),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '  email'),
              onSaved: (val) => setState(() => _user.email = val!),
              validator: (val) => (val!.length < 11 ? 'email not valide' : null),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '  password'),
              onSaved: (val) => setState(() => _user.password = val!),
              validator: (val) =>
                  (val!.length < 3 ? 'password at least 4 caracters' : null),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                onPressed: () => _onSubmit(),
                child: Text('Submit'),
                color: darkBlueColor,
                textColor: Colors.white,

              ),
            ),
          ],),
        ),
      ),
    );
  }

  _onSubmit() {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        var name =_user.name;
        var email =_user.email;
        var password =_user.password;
        createUser(User(name:name,email: email,password: password,is_Active: true),);
      });
      Navigator.push(context, new MaterialPageRoute(builder: (context) => MyList()));
    }
  }
  Future<User> createUser(User user) async {

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );
    if (response.statusCode == 201) {

      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }
}
