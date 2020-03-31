// card stats widget

import 'package:flutter/material.dart';

Widget cardBig(
  BuildContext context,
  String title,
  int value,
  MaterialColor color,
) {
  return Card(
      color: color,
      child: Container(
          width: (MediaQuery.of(context).size.width - 24),
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title),
              Text(value.toString()),
              Text("(Today cases 1234)")
            ],
          )));
}
