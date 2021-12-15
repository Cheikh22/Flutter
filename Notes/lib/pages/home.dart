import 'package:flutter/material.dart';
import 'form.dart';
import 'list.dart';

const darkBlueColor = Color(0xff486579);

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _titles = ['List', 'Form'];
  var _widgets = [MyList(), MyForm()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Center(
            child: Text(_titles[_currentIndex]),
          ),
          foregroundColor: darkBlueColor,
          backgroundColor: Colors.white,
        ),
        body: _widgets[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.table_chart), label: 'List'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Form'),
          ],
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
        ),
      ),
    );
  }
}
