import 'dart:developer';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:covid19_dashboard/page/country.dart';
import 'package:covid19_dashboard/service/corona_service.dart';
import 'package:covid19_dashboard/utils/utils.dart';
import 'package:covid19_dashboard/widget/stats_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  CoronaService coronaService = new CoronaService();

  @override
  void initState() {
    super.initState();

    // overall stats
    overallStats = coronaService.fetchOverallStats();
    overallStats.then((stats) {
      setState(() {
        casesStats = stats.cases;
        deathsStats = stats.deaths;
        recoveriesStats = stats.recovered;
      });
    });

    // country stats
    overallCountryStats = coronaService.fetchOverallCountryStats();
    overallCountryStats.then((stats) {
      stats.forEach((item) {
        log(item.country);
        log(coronaService.getFlagImage(item.country));
      });
    });
  }

  // list tile for affected country list
  buildList(CountryStats countryStats) {
    var numFormat = new NumberFormat("###,###", Intl.defaultLocale);

    return ListTile(
        leading: new Image.asset(
          coronaService.getFlagImage(countryStats.country),
          width: 48,
          height: 48,
        ),
        title: Text(countryStats.country),
        subtitle: Row(
          children: <Widget>[
            Text(numFormat.format(countryStats.cases) + " Cases"),
            Text(" & "),
            Text(numFormat.format(countryStats.deaths) + " Deaths")
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
                cardBig(context, Colors.blue, "Inflections", casesStats, null),
                cardSmall(context, Colors.red, "Deaths", deathsStats, null),
                cardSmall(
                    context, Colors.green, "Recovered", recoveriesStats, null),
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
                future: coronaService.fetchOverallCountryStats(),
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
