import 'dart:developer';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/page/country.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:covid19_dashboard/utils/utils.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<OverallStats> overallStats;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // overall stats
    overallStats = fetchOverallStats();
    overallStats.then((stats) {
      log(stats.cases.toString());
    });

    // country stats
    Future<List<CountryStats>> overallCountryStats;
    overallCountryStats = fetchOverallCountryStats();
    overallCountryStats.then((stats) {
      stats.forEach((item) {
        log(item.country);
      });
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
            // wrap overall statistic
            Wrap(
              children: <Widget>[
                Card(
                    color: Colors.blue,
                    child: Container(
                        width: (MediaQuery.of(context).size.width * 0.5) - 16,
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
                            Text("(Today cases 1234)")
                          ],
                        ))),
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
                            Text("(Today cases 1234)")
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
                            Text("(Today cases 1234)")
                          ],
                        ))),
              ],
            ),
            // title countries statistics
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Countries Statistics")),
            // list view for country statistics
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Image.asset(
                        'icons/flags/png/th.png',
                        package: 'country_icons',
                        width: 50,
                      ),
                      title: Text("xxx"),
                      subtitle: Row(
                        children: <Widget>[
                          Text("1234" + " Cases"),
                          Text(" & "),
                          Text("1234" + " Deaths")
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context, ScaleRoute(page: CountryPage()));
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
