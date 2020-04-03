import 'dart:developer';
import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:covid19_dashboard/widget/stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    var numFormat = new NumberFormat("###,###", Intl.defaultLocale);

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
                      padding: EdgeInsets.all(8),
                      child: Image.asset(
                        coronaService.getFlagImage(this.title),
                        height: 40,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        this.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    )
                  ],
                ),

                // Row cases
                Row(
                  children: <Widget>[
                    cardBig(context, Colors.blue, "Inflections", data.cases,
                        "(Today " + numFormat.format(data.todayCases) + ")"),
                  ],
                ),

                // Row recoveries
                Wrap(children: <Widget>[
                  cardSmall(
                      context, Colors.green, "Recoverd", data.recovered, null),
                  cardSmall(
                      context, Colors.amber, "Critical", data.critical, null),
                  cardSmall(context, Colors.cyan, "Active", data.active, null),
                  cardSmall(context, Colors.red, "Deaths", data.deaths,
                      "(Today " + numFormat.format(data.todayDeaths) + ")"),
                ])
              ],
            ),
          )),
    );
  }
}
