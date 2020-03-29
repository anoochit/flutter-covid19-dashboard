import 'dart:convert';
import 'dart:io';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:http/http.dart' as http;

// https://github.com/OssamaRafique/Corona-Statistics-And-Tracker-Dashboard-Angular-9
// http://api.coronastatistics.live/countries/[country-name]

String _stats_country = "http://api.coronastatistics.live/countries/thailand";

Future<CountryStats> fetchCountryStatistic() async {
  final response = await http.get(_stats_country);

  if (response.statusCode == HttpStatus.ok) {
    return CountryStats.fromJson(json.decode(response.body));
  } else {
    throw Exception("failed to load data");
  }
}
