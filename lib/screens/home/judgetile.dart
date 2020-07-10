import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/home/judge.dart';
import 'package:SportIQ/services/database.dart';
import 'package:SportIQ/shared/loading.dart';


class JudgeTile extends StatelessWidget {
  
  final Users users;
  JudgeTile({this.users});

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;

        if(snapshot.data != null){
        if (userData.name != users.name) {
          return Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.cyan[700]
                ),
                title: Text('Debate about ${users.topicChoice}'),
                subtitle: Text('Has been judged 0/3 times'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Judge(
                        peerId: users.uid,
                        appName: userData.name,
                        peerName: users.name
                      )
                    )
                  );
                }, 
              ),
            ),  
          );
        } else {
          return Container(
            height: 0.0,
            width: 0.0,
          );
        }
        } else {
          return Loading();
        }
      }
    );
  }
}