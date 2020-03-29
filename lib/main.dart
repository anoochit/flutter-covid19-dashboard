import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';

import 'page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Statistic',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
