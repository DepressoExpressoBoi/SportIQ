import 'package:flutter/material.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

