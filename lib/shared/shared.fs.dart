import 'package:flutter/material.dart';

Widget smallButton({String name}) {
  Widget widget = Column(children: [
    Container(
      color: Colors.tealAccent,
      child: Text(
        '$name',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    )
  ]);
  return widget;
}
