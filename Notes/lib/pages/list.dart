import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notes/models/user.dart';
import 'dart:async';

const darkBlueColor = Color(0xff486579);

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  void initState() { 
    super.initState();
    _getUsersList();
  }
  List<User> _users = [];
  User _user = User();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child:Card(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: FutureBuilder(
          future: _getUsersList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.data == null){
              return CircularProgressIndicator();
            }else{
              return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount:snapshot.data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: darkBlueColor,
                        size: 40.0,
                      ),
                      title: Text(
                        snapshot.data[index].name!.toUpperCase(),
                        style: TextStyle(
                            color: darkBlueColor, fontWeight: FontWeight.bold),
                      ),
                    subtitle:Text(snapshot.data[index].email!),
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
  Future _getUsersList() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/users'));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<User> _users = items.map<User>((json) {
      return User.fromJson(json);
      }).toList();
      print(_users);
    return _users;
   }
}
