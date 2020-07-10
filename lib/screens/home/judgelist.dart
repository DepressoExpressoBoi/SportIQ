import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';

import 'judgetile.dart';

class JudgeList extends StatefulWidget {
  @override
  _JudgeList createState() => _JudgeList();
}

class _JudgeList extends State<JudgeList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<Users>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return JudgeTile(users: users[index]);
      },
    );
  }
}