import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'chattile.dart';

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<Users>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ChatTile(users: users[index]);
      },
    );
  }
}