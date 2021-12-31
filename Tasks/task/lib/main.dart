
import 'package:flutter/material.dart';
import 'package:task/router.dart';

void main() {
  runApp(Tasks(
    router: AppRouter(),
  ));
}

class Tasks extends StatelessWidget {
  final AppRouter? router;

  const Tasks({Key? key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router!.generateRoute,
    );
  }
}
