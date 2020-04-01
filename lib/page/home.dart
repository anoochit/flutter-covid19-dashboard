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
  Future<List<CountryStats>> overallCountryStats;
  int overallCountryStatsSize = 0;

  int casesStats = 0;
  int deathsStats = 0;
  int recoveriesStats = 0;
  int criticalStats = 0;

  @override
  void initState() {
    super.initState();

    // overall stats
    overallStats = fetchOverallStats();
    overallStats.then((stats) {
      setState(() {
        casesStats = stats.cases;
        deathsStats = stats.deaths;
        recoveriesStats = stats.recovered;
      });
    });

    // country stats
    overallCountryStats = fetchOverallCountryStats();
    overallCountryStats.then((stats) {
      stats.forEach((item) {
        log(item.country);
        log(getFlagImage(item.country));
      });
    });
  }

  // list tile for affected country list
  buildList(CountryStats countryStats) {
    return ListTile(
        leading: new Image.asset(
          getFlagImage(countryStats.country),
          width: 48,
          height: 48,
        ),
        title: Text(countryStats.country),
        subtitle: Row(
          children: <Widget>[
            Text(countryStats.cases.toString() + " Cases"),
            Text(" & "),
            Text(countryStats.deaths.toString() + " Deaths")
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              ScaleRoute(
                  page: CountryPage(
                      title: countryStats.country, data: countryStats)));
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
                        width: (MediaQuery.of(context).size.width) - 24,
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Infections"),
                            Text(casesStats.toString()),
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
                            Text(deathsStats.toString()),
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
                            Text(recoveriesStats.toString()),
                          ],
                        ))),
              ],
            ),

            // title countries statistics
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Affected Countries")),

            // list view for country statistics
            Expanded(
              child: FutureBuilder(
                future: fetchOverallCountryStats(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    List<CountryStats> data = snapshot.data;
                    // show data
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildList(snapshot.data[index]);
                      },
                    );
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(width: 16),
                        Text("Loading...")
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
