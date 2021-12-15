import 'package:flutter/material.dart';
import 'package:notes/models/user.dart';

const darkBlueColor = Color(0xff486579);

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {

  final _formKey = GlobalKey<FormState>();
  List<User> _users =[];
  User _user = User();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
        _users.add(_user);
      });
      print(_user.name);
      print(_user.email);
      print(_user.password);
    }
  }
}
