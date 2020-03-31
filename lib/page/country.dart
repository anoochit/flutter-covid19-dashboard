import 'dart:developer';
import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  CountryPage({Key key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Future<CountryStats> countryStats;

  @override
  void initState() {
    super.initState();
    countryStats = fetchCountryStats("thailand");
    countryStats.then((stats) {
      log(stats.cases.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thailand's statistics")),
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
                        'icons/flags/png/th.png',
                        package: 'country_icons',
                        width: 50,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        child: Text("Thailand's statistics"))
                  ],
                ),

                // Row 1 cases
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
