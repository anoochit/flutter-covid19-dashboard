// card stats widget

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget cardBig(
  BuildContext context,
  MaterialColor color,
  String title,
  int value,
  String subtitle,
) {
  var numFormat = new NumberFormat("###,###", Intl.defaultLocale);
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
              Text(numFormat.format(value)),
              (subtitle != null) ? Text(subtitle.toString()) : Container(),
            ],
          )));
}

Widget cardSmall(
  BuildContext context,
  MaterialColor color,
  String title,
  int value,
  String subtitle,
) {
  var numFormat = new NumberFormat("###,###", Intl.defaultLocale);
  return Card(
      color: color,
      child: Container(
          width: (MediaQuery.of(context).size.width * 0.5) - 16,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(title),
              Text(numFormat.format(value)),
              (subtitle != null) ? Text(subtitle.toString()) : Container(),
            ],
          )));
}
