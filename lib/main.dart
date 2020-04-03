import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final CoronaService coronaService = CoronaService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => coronaService.fetchOverallStats()),
        FutureProvider(
            create: (context) => coronaService.fetchOverallCountryStats())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid-19 Statistic',
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}
