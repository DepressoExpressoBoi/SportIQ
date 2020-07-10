import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/authenticate/questionairescreen.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/services/database.dart';
import 'package:SportIQ/shared/loading.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override 
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

      return StreamBuilder(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
        UserData userData = snapshot.data;
        if (snapshot.hasData) {
          if(userData.registered == 0) {
            return QuestionaireScreen();
          } else {
            return ProfileScreen();
          }
        } else {
          return Loading();
        }
        }
      );
  }
}