import 'dart:developer';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<CountryStats> countryStats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryStats = fetchCountryStatistic();
    countryStats.then((stats) {
      log(stats.cases.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid 19 Dashboard"),
        elevation: 0.0,
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              // Row 1 cases
              Card(
                  color: Colors.blue,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Cases"),
                          Text("1234"),
                          Text("(Today cases 1234)")
                        ],
                      ))),
              // Row 2
              Row(children: <Widget>[
                Card(
                    color: Colors.green,
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.5) - 16,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Recoveries"),
                            Text("1234"),
                          ],
                        ))),
                Card(
                    color: Colors.amber[600],
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.5) - 16,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Critical"),
                            Text("1234"),
                          ],
                        ))),
              ]),
              // Row 3
              Row(children: <Widget>[
                Card(
                    color: Colors.cyan,
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.5) - 16,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Active"),
                            Text("1234"),
                          ],
                        ))),
                Card(
                    color: Colors.red,
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.5) - 16,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Deaths"),
                            Text("1234"),
                          ],
                        ))),
              ])
            ],
          )),
    );
  }
}
