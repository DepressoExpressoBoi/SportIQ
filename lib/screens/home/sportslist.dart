import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/screens/home/sportstile.dart';

class SportsList extends StatefulWidget {
  @override
  _SportsListState createState() => _SportsListState();
}

class _SportsListState extends State<SportsList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<Users>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return SportsTile(users: users[index]);
      },
    );
  }
}