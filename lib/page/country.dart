import 'dart:developer';
import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final String title;
  CountryPage({Key key, this.title}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState(this.title);
}

class _CountryPageState extends State<CountryPage> {
  final String title;
  Future<CountryStats> countryStats;

  _CountryPageState(this.title);

  @override
  void initState() {
    super.initState();
    countryStats = fetchCountryStats(title);
    countryStats.then((stats) {
      log(stats.cases.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title + "'s statistics")),
      body: SafeArea(
          minimum: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(4),
                      child: Image.asset(
                        'assets/flags/th.png',
                        height: 48,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        child: Text("Thailand's statistics"))
                  ],
                ),

                // Row cases
                Row(
                  children: <Widget>[
                    Card(
                        color: Colors.blue,
                        child: Container(
                            width: (MediaQuery.of(context).size.width - 24),
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Infections"),
                                Text("1234"),
                                Text("(Today cases 1234)")
                              ],
                            ))),
                  ],
                ),

                // Row recoveries
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

                // Row active
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
                              Text("11"),
                            ],
                          ))),
                ])
              ],
            ),
          )),
    );
  }
}
