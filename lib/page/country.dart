import 'dart:developer';
import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  final String title;
  final CountryStats data;
  CountryPage({Key key, this.title, this.data}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState(this.title, this.data);
}

class _CountryPageState extends State<CountryPage> {
  final String title;
  final CountryStats data;
  _CountryPageState(this.title, this.data);

  Future<CountryStats> countryStats;
  CoronaService coronaService = new CoronaService();

  @override
  void initState() {
    super.initState();
    countryStats = coronaService.fetchCountryStats(title);
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
                        coronaService.getFlagImage(this.title),
                        height: 48,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(4),
                        child: Text(this.title + "'s statistics"))
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
                                Text(data.cases.toString()),
                                Text("(Today cases " +
                                    data.todayCases.toString() +
                                    " )")
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
                              Text(data.recovered.toString()),
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
                              Text(data.critical.toString()),
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
                              Text(data.active.toString()),
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
                              Text(data.deaths.toString()),
                              Text("(Today deaths " +
                                  data.todayDeaths.toString() +
                                  " )")
                            ],
                          ))),
                ])
              ],
            ),
          )),
    );
  }
}
