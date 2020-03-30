import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:covid19_dashboard/model/corona_model.dart';
import 'package:http/http.dart' as http;

// https://github.com/OssamaRafique/Corona-Statistics-And-Tracker-Dashboard-Angular-9
// http://api.coronastatistics.live/countries/[country-name]

String _statsCountry = "http://api.coronastatistics.live/countries/thailand";

Future<CountryStats> fetchCountryStatistic() async {
  final response = await http.get(_statsCountry);

  if (response.statusCode == HttpStatus.ok) {
    log(response.body.toString());
    return CountryStats.fromJson(json.decode(response.body));
  } else {
    throw Exception("failed to load data");
  }
}
