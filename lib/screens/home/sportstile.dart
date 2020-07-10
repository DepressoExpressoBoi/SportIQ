import 'package:flutter/material.dart';
import 'package:SportIQ/models/sports.dart';

class SportsTile extends StatelessWidget {
  
  final Users users;
  SportsTile({this.users});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.cyan[700]
          ),
          title: Text(users.name),
          subtitle: Text('Has won ${users.tournamentsWon} tournaments'),
        ),
      ),  
    );
  }
}